# == Schema Information
#
# Table name: grupo_documentos_unos
#
#  id         :integer          not null, primary key
#  mensaje    :string(100)      default(""), not null
#  icon_color :string(15)       default(""), not null
#  created_at :datetime
#  updated_at :datetime
#

class GrupoDocumentosUno < ActiveRecord::Base
  has_many :documentos_requisitos_por_vistas
end
