# == Schema Information
#
# Table name: documentos
#
#  id                                 :integer          not null, primary key
#  doc                                :string(255)
#  nombre                             :string(255)
#  modelo_id                          :integer
#  modelo_type                        :string(255)
#  created_at                         :datetime
#  updated_at                         :datetime
#  documentos_requisitos_por_vista_id :integer
#
# Indexes
#
#  index_control_documentos                                (doc,modelo_id,modelo_type,documentos_requisitos_por_vista_id) UNIQUE
#  index_documentos_on_documentos_requisitos_por_vista_id  (documentos_requisitos_por_vista_id)
#  index_documentos_on_modelo_id                           (modelo_id)
#

class Documento < ActiveRecord::Base

  include Rails.application.routes.url_helpers

  belongs_to :documentos_requisitos_por_vista
  belongs_to :modelo, polymorphic: true

  default_scope -> { order(created_at: :asc) }

  #mount_uploader :doc, ImgDocUploader

  validate :doc_not_empty
  validate :doc_size
  validate :check_cardinality
  after_destroy :remove_directory



  def nombre_vista
    self.documentos_requisitos_por_vista.vista.nombre
  end

  def nombre_requisito
    self.documentos_requisitos_por_vista.documento_requisito.nombre
  end



  def to_jq_upload
    {
        "name" => read_attribute(:doc).sub(/\A\d+-/,''),
        "size" => doc.size,
        "url" => doc.url,
        "thumbnail_url" => doc.thumb.url,
        "delete_url" => jquery_file_upload_path(:id => id),
        "delete_type" => "DELETE"
    }
  end

  def pdf?
    return true if nombre_documento.present? and nombre_documento.split('.').last == 'pdf'
    return false
  end

  # def self.solicitud_documento_requisito(solicitud, documento_requisito)
  #   return Documento.find_by_sql ['
  #     SELECT
  #           documentos.*
  #       FROM
  #           public.solicituds,
  #           public.documento_requisitos ,
  #           public.documentos
  #       WHERE
  #           solicituds.id = documentos.solicitud_id AND
  #           documento_requisitos.id = documentos.documento_requisito_id AND
  #           solicituds.id = ? AND
  #           documento_requisitos.nombre = ?', solicitud, documento_requisito]
  # end

  def self.find_documentos(modelo_id,modelo_type, documento_requisito_por_vista_id)
    return Documento.find_by_sql ['
       SELECT
          documentos.*
       FROM
         public.documentos,
         public.documentos_requisitos_por_vistas
       WHERE
         documentos.documentos_requisitos_por_vista_id = documentos_requisitos_por_vistas.id AND
         documentos.modelo_id=? AND
         documentos.modelo_type=? AND
         documentos_requisitos_por_vistas.id=?', modelo_id,modelo_type,documento_requisito_por_vista_id]
  end

  def document_path
    "#{self.modelo_type}-FILES-SIMAPRO/#{self.modelo_id}/"+
        "#{self.nombre_vista.upcase}/"+
        "#{self.nombre_requisito.upcase}/#{self.id}/#{self.nombre}"
  end

  def cadinalidad_model_documento_requisito
    Documento.includes(documentos_requisitos_por_vista: :documento_requisito ).where(documento_requisitos:{nombre:self.documentos_requisitos_por_vista.documento_requisito.nombre },id: self.id).length
  end

  def nombre_documento
    self.doc.to_s.split('/').last.sub(/\A\d+-/,'')
  end

  def documento_requisito
    documentos_requisitos_por_vista.documento_requisito
  end

  def grupo_documentos_uno
    documentos_requisitos_por_vista.grupo_documentos_uno
  end

  def vista
    documentos_requisitos_por_vista.vista
  end

  private

  def remove_directory
    path = File.expand_path(doc.store_path, doc.root)
    FileUtils.remove_dir(path, force: false)
  end

  def check_cardinality
    unless self.documentos_requisitos_por_vista.documento_requisito.paginado?
      maxima = self.documentos_requisitos_por_vista.documento_requisito.cardinalidad_maxima
      if cadinalidad_model_documento_requisito >= maxima and self.id.blank?
        if maxima == 1
          self.errors[:base] << "El documento #{self.documentos_requisitos_por_vista.documento_requisito.descripcion} es único, posiblemenete este recargando la página"
        else
          self.errors[:base] << "El documento #{self.documentos_requisitos_por_vista.documento_requisito.descripcion} alcanzó la maxima cantidad de documentos, posiblemenete este recargando la página"
        end
      end
    end
  end

  def doc_size
    if self.doc.file.present? && self.doc.file.size.to_f/1.megabyte > 2.megabyte
      errors.add(:doc, "Los documentos no pueden tener un tamaño mayor a 2 MB")
    end
  end

  def doc_not_empty
    if self.documentos_requisitos_por_vista.documento_requisito.obligatorio && self.doc.blank?
      self.errors[:base] << "El documento #{self.documentos_requisitos_por_vista.documento_requisito.descripcion} es obligatorio"
    elsif self.doc.blank?
      self.destroy
    end
  end

end
