# == Schema Information
#
# Table name: documentos_requisitos_por_vistas
#
#  id                      :integer          not null, primary key
#  documento_requisito_id  :integer
#  vista_id                :integer
#  grupo_documentos_uno_id :integer
#  created_at              :datetime
#  updated_at              :datetime
#
# Indexes
#
#  index_doc_requisito_intermedia         (documento_requisito_id)
#  index_documentos_unique_vista          (documento_requisito_id,vista_id) UNIQUE
#  index_grupo_documentos_uno_intermedia  (grupo_documentos_uno_id)
#  index_vista_intermedia                 (vista_id)
#

class DocumentosRequisitosPorVista < ActiveRecord::Base
  #config/includes
  self.table_name = :documentos_requisitos_por_vistas

  #associations
  belongs_to :documento_requisito
  belongs_to :vista
  belongs_to :grupo_documentos_uno
  has_many :documentos

  def self.find_by_tupla(nombre_vista,nombre_requisito)
    array = DocumentosRequisitosPorVista.find_by_sql ['
           SELECT
             public.documentos_requisitos_por_vistas.*
           FROM
              public.documento_requisitos,
              public.documentos_requisitos_por_vistas,
              public.vistas
           WHERE
            documento_requisitos.id = documentos_requisitos_por_vistas.documento_requisito_id AND
            vistas.id = documentos_requisitos_por_vistas.vista_id  AND
            documento_requisitos.nombre=? AND vistas.nombre=?',
                                                      nombre_requisito,
                                                      nombre_vista
                                                     ]
    array.last
  end

  def self.show_documentos_no_paginados(nombre_vista)
    self.find_by_sql ['
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
          vistas.nombre = ?
        ORDER BY
          documento_requisitos.created_at', nombre_vista]
  end

  def self.vista_completa?(nombre_vista,modelo,document_filter = :none)
    if Vista.find_by(nombre: nombre_vista).grupos?
      flag = consulta(nombre_vista,modelo,document_filter){|consulta| (self.find_by_sql consulta ).empty?}
      flag &&= (not consulta(nombre_vista,modelo,:almenos_uno){|consulta| (self.find_by_sql consulta ).empty?})
      return flag
    else
      return consulta(nombre_vista,modelo,document_filter){|consulta| (self.find_by_sql consulta ).empty?}
    end
  end

  def self.consulta(nombre_vista,modelo,document_filter)
    case document_filter
      when :none
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
              vistas.id = documentos_requisitos_por_vistas.vista_id  AND
              vistas.nombre = ? AND documento_requisitos.obligatorio= 'TRUE') AS dr_v
            LEFT JOIN
              (SELECT
                  documentos.*
                FROM
                  public.#{modelo.class.table_name},
                  public.documentos
                WHERE
                  #{modelo.class.table_name}.id = documentos.modelo_id AND documentos.modelo_type = ?  AND #{modelo.class.table_name}.id=#{modelo.id})
                AS d
            ON d.documentos_requisitos_por_vista_id = dr_v.id
          WHERE
            d.documentos_requisitos_por_vista_id IS NULL ORDER BY created_at;",
               nombre_vista,
               modelo.class
        ]
      when :almenos_uno
        yield ["SELECT *
              FROM
                (
                SELECT
                  grupo_documentos_unos.*
                FROM
                  public.vistas,
                  public.documentos_requisitos_por_vistas,
                  public.documento_requisitos,
                  public.grupo_documentos_unos
                WHERE
                  vistas.id = documentos_requisitos_por_vistas.vista_id AND
                  documento_requisitos.id = documentos_requisitos_por_vistas.documento_requisito_id AND
                  grupo_documentos_unos.id = documentos_requisitos_por_vistas.grupo_documentos_uno_id AND
                  vistas.nombre= ?
                  GROUP BY grupo_documentos_unos.id)
                  as dr_uno
              LEFT JOIN
                (
                SELECT
                  *
                FROM
                  public.documentos_requisitos_por_vistas,
                  public.#{modelo.class.table_name},
                  public.documentos,
                  public.vistas
                WHERE
                  documentos_requisitos_por_vistas.vista_id = vistas.id AND vistas.nombre= ? AND
                  documentos.modelo_id = #{modelo.class.table_name}.id AND documentos.modelo_type = ? AND
                  documentos.modelo_id = ?  AND
                  documentos.documentos_requisitos_por_vista_id = documentos_requisitos_por_vistas.id AND
                  documentos_requisitos_por_vistas.grupo_documentos_uno_id IS NOT NULL)
                  as d
              ON d.grupo_documentos_uno_id = dr_uno.id
              WHERE d.grupo_documentos_uno_id IS NOT NULL;",
               nombre_vista,
               nombre_vista,
               modelo.class,
               modelo.id
        ]

      when :only_paginate
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
              vistas.id = documentos_requisitos_por_vistas.vista_id  AND
               documento_requisitos.paginado = TRUE AND
              vistas.nombre = ? AND documento_requisitos.obligatorio= 'TRUE') AS dr_v
            LEFT JOIN
              (SELECT
                  documentos.*
                FROM
                  public.#{modelo.class.table_name},
                  public.documentos
                WHERE
                  #{modelo.class.table_name}.id = documentos.modelo_id AND documentos.modelo_type = ?  AND #{modelo.class.table_name}.id=#{modelo.id})
                AS d
            ON d.documentos_requisitos_por_vista_id = dr_v.id
          WHERE
            d.documentos_requisitos_por_vista_id IS NULL ORDER BY created_at;",
               nombre_vista,
               modelo.class
        ]
      when :only_no_paginate
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
              vistas.id = documentos_requisitos_por_vistas.vista_id  AND
              documento_requisitos.paginado = FALSE AND
              vistas.nombre = ? AND documento_requisitos.obligatorio= 'TRUE') AS dr_v
            LEFT JOIN
              (SELECT
                  documentos.*
                FROM
                  public.#{modelo.class.table_name},
                  public.documentos
                WHERE
                  #{modelo.class.table_name}.id = documentos.modelo_id AND documentos.modelo_type = ?  AND #{modelo.class.table_name}.id=#{modelo.id})
                AS d
            ON d.documentos_requisitos_por_vista_id = dr_v.id
          WHERE
            d.documentos_requisitos_por_vista_id IS NULL ORDER BY created_at;",
               nombre_vista,
               modelo.class
        ]

    end
  end
end
