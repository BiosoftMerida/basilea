module ManageDocumentHelper

  #######################################################################################
  ########## METODO PARA INICIALIZAR LOS DOCUMENTOS Y MOSTRARLOS EN LAS VISTAS ##########
  ##########                      SEGUN EL NOMBRE DE LA VISTA         ###################
  #######################################################################################
  def load_documentos(nombre_vista, modelo,reload=false)
    modelo.documentos(reload) if reload
    documento_requisitos_por_vista_show = DocumentosRequisitosPorVista.show_documentos_no_paginados(nombre_vista)

    documento_requisitos_por_vista = consulta(nombre_vista,modelo)  {|consulta| DocumentosRequisitosPorVista.find_by_sql consulta}

    loop_build_documentos(documento_requisitos_por_vista, modelo)
    cargar_documentos(documento_requisitos_por_vista_show, modelo)
  end

  protected
  def loop_build_documentos(documento_requisitos_por_vista, modelo)
    documento_requisitos_por_vista.each do |intermedia|
      modelo.documentos.build(documentos_requisitos_por_vista_id: intermedia.id)
    end
  end

  def cargar_documentos(documento_requisitos_por_vista, modelo)
    documentos = Array.new
    modelo.documentos.to_a.each do |d|
      documento_requisitos_por_vista.each do |documento|
        # next  if not cargar_paginados and documento.documento_requisito.paginado
        if d.documentos_requisitos_por_vista_id == documento[:id]
          documentos<<d
          break
        end
      end
    end
    return documentos
  end

  def consulta(nombre_vista, modelo)
    if modelo.new_record?
      yield ['
          SELECT
              documentos_requisitos_por_vistas.*
            FROM
              public.documento_requisitos,
              public.documentos_requisitos_por_vistas,
              public.vistas
            WHERE
              documento_requisitos.id = documentos_requisitos_por_vistas.documento_requisito_id AND
              vistas.id = documentos_requisitos_por_vistas.vista_id AND
              documento_requisitos.paginado = FALSE AND
              vistas.nombre = ?;',
             nombre_vista
      ]
    else
      yield ["
          SELECT dr_v.*
          FROM
            (SELECT
              documentos_requisitos_por_vistas.*
            FROM
              public.documento_requisitos,
              public.documentos_requisitos_por_vistas,
              public.vistas
            WHERE
              documento_requisitos.id = documentos_requisitos_por_vistas.documento_requisito_id AND
              vistas.id = documentos_requisitos_por_vistas.vista_id AND
              documento_requisitos.paginado = FALSE AND
              vistas.nombre = ?) AS dr_v
            LEFT JOIN
              (SELECT
                  documentos.*
                FROM
                  public.#{modelo.class.table_name},
                  public.documentos
                WHERE
                  #{modelo.class.table_name}.id = documentos.modelo_id AND documentos.modelo_type = ? AND #{modelo.class.table_name}.id=#{modelo.id} )
                AS d
            ON d.documentos_requisitos_por_vista_id = dr_v.id
          WHERE
            d.documentos_requisitos_por_vista_id IS NULL ORDER BY created_at;",
             nombre_vista,
             modelo.class
      ]
    end
  end

  # def cargar_documentos_verificacion(solicitud, tramite)
  #   documento_requisitos =
  #       DocumentoRequisito.find_by_solicitud_grupo_requisitos(nombre_solicitud,
  #                                                             tramite)
  #   cargar_documentos(documento_requisitos,solicitud)
  # end

  # private_class_method
end