class Evento < ActiveRecord::Base
  belongs_to :empresa
  has_many :inscripcion_eventos

  validates :nombre, :descripcion, :fecha_inicio, :fecha_fin, :email_contacto, :tlf_contacto, :cupos, :lugar,
            :horario, :mensaje_invitacion, presence: true
  validates :nombre, uniqueness: {message:'Otro evento a sido registrado con este nombre.'}


  def safe_to_delete
    if self.inscripcion_eventos.any?
      return false
    else
      return true
    end
  end
end

