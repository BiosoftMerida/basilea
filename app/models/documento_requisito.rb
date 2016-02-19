# == Schema Information
#
# Table name: documento_requisitos
#
#  id                  :integer          not null, primary key
#  nombre              :string(50)       not null
#  descripcion         :string(100)      not null
#  help                :string(100)
#  cardinalidad_maxima :integer          default(1)
#  paginado            :boolean          default(FALSE), not null
#  obligatorio         :boolean          default(TRUE), not null
#  almenos_uno         :boolean          default(FALSE), not null
#  created_at          :datetime
#  updated_at          :datetime
#
# Indexes
#
#  index_documento_requisitos_on_nombre  (nombre) UNIQUE
#

class DocumentoRequisito < ActiveRecord::Base

  has_many :documentos_requisitos_por_vistas
  has_many :vistas, through: :documentos_requisitos_por_vistas

  default_scope -> { order(created_at: :asc) }

  # def self.find_by_solicitud_grupo_requisitos(nombre_solicitud, grupo_requisito)
  #  self.find_by_sql ["
  #        SELECT
  #           documento_requisitos.*
  #         FROM
  #           public.tipo_solicituds,
  #           public.documento_requisitos ,
  #           public.grupo_requisitos
  #         WHERE
  #           tipo_solicituds.id = grupo_requisitos.tipo_solicitud_id AND
  #           grupo_requisitos.id = documento_requisitos.grupo_requisito_id AND
  #           tipo_solicituds.nombre = ? AND
  #           grupo_requisitos.nombre = ? ORDER BY documento_requisitos.created_at", nombre_solicitud, grupo_requisito]
  # end
end
