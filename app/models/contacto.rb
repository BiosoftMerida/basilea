class Contacto < ActiveRecord::Base
  belongs_to :pais
  belongs_to :estado
  belongs_to :profesion
  belongs_to :ministerio
  belongs_to :empresa
  has_many :inscripcion_eventos

  validates :nombres, :apellidos, :doc_identidad, :email, :telefono, :recomendado_por, :empresa_id,
            :pais_id, :profesion_id, :ministerio_id, presence: true
  validates :email, uniqueness: {message:'Ya existe el e-mail ingresado. Debe ingresar su e-mail.'}
  validates :doc_identidad, uniqueness: {message:'Ya existe el nro. de documento de identidad.'}


  def safe_to_delete
    if self.inscripcion_eventos.any?
      return false
    else
      return true
    end
  end

end
