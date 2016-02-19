module ModeloGeneral
  module ManageDocument
    def documentos_vista(nombre_vista)
    return Documento.find_by_sql ["
      SELECT d.*
        FROM
        ( SELECT
              documentos_requisitos_por_vistas.id as id
            FROM
              public.documentos_requisitos_por_vistas,
              public.documento_requisitos,
              public.vistas
            WHERE
              documento_requisitos.id = documentos_requisitos_por_vistas.documento_requisito_id AND
              vistas.id = documentos_requisitos_por_vistas.vista_id AND
              documento_requisitos.paginado = FALSE AND
              vistas.nombre = ? ) AS dr
            LEFT JOIN (
             SELECT
            documentos.*
          FROM
            public.documentos,
            public.#{self.class.table_name}
          WHERE
           documentos.modelo_id = #{self.class.table_name}.id AND
           documentos.modelo_type = ? AND #{self.class.table_name}.id=? ) as d
         ON d.documentos_requisitos_por_vista_id = dr.id
         WHERE d.id IS NOT NULL  ORDER BY d.created_at;", nombre_vista, self.class,self.id]
    end

    def documento (nombre_vista,nombre_documento_requisito)

      return (Documento.find_by_sql ["
      SELECT d.*
        FROM
          (
            SELECT
              documentos_requisitos_por_vistas.id as id
            FROM
              public.documentos_requisitos_por_vistas,
              public.documento_requisitos,
              public.vistas
            WHERE
              documento_requisitos.id = documentos_requisitos_por_vistas.documento_requisito_id AND
              vistas.id = documentos_requisitos_por_vistas.vista_id AND documento_requisitos.nombre=? AND
              documento_requisitos.paginado = FALSE AND
              vistas.nombre = ?)as dr
        LEFT JOIN (
          SELECT
            documentos.*
          FROM
            public.documentos,
            public.#{self.class.table_name}
          WHERE
           documentos.modelo_id = #{self.class.table_name}.id AND
           documentos.modelo_type = ? AND #{self.class.table_name}.id=? ) as d
        ON d.documentos_requisitos_por_vista_id = dr.id;",nombre_documento_requisito,
                                    nombre_vista, self.class,self.id]).last
    end

    def documentos_paginados(nombre_vista)
      return Documento.find_by_sql ["SELECT d.*
        FROM
        ( SELECT
              documentos_requisitos_por_vistas.id as id
            FROM
              public.documentos_requisitos_por_vistas,
              public.documento_requisitos,
              public.vistas
            WHERE
              documento_requisitos.id = documentos_requisitos_por_vistas.documento_requisito_id AND
              vistas.id = documentos_requisitos_por_vistas.vista_id AND
              documento_requisitos.paginado = TRUE AND
              vistas.nombre = ? ) AS dr
            LEFT JOIN (
             SELECT
            documentos.*
          FROM
            public.documentos,
            public.#{self.class.table_name}
          WHERE
           documentos.modelo_id = #{self.class.table_name}.id AND
           documentos.modelo_type = ? AND #{self.class.table_name}.id=? ) as d
         ON d.documentos_requisitos_por_vista_id = dr.id
         WHERE d.id IS NOT NULL
         GROUP BY d.documentos_requisitos_por_vista_id ,d.id,d.doc,d.nombre,d.modelo_id,
                  d.updated_at,d.modelo_type,d.modelo_id,d.created_at
         ORDER BY d.created_at ;",  nombre_vista, self.class,self.id]
    end

    def documento_requisito_paginados_completos?(nombre_vista,modelo)

          return true if DocumentosRequisitosPorVista.vista_completa?(nombre_vista,modelo,:only_paginate)

          self.errors[:base] << 'Completar los Documentos Páginados que son Obligatorios'
          return false
    end

    # #callback declaration
    # validate :almenos_uno
    #
    # #callbacks definition
    def almenos_uno

      valid_form = Array.new
      group_ids  = Array.new

      documentos.each do |documento|
        if documento.documento_requisito.almenos_uno
          index = group_ids.index( documento.grupo_documentos_uno.id)
          if index.nil?
            group_ids << documento.grupo_documentos_uno.id
            valid_form << false
            index =  group_ids.length - 1
          end

          unless documento.doc.blank?
            valid_form[index] = true
          end
        end
      end

      valid_form.each_with_index do |item,i|
        unless item
          grupo_almenos_uno = GrupoDocumentosUno.find_by(id:group_ids[i])
          self.errors[:base] << grupo_almenos_uno.mensaje
        end
      end
    end

  end

end