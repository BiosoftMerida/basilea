# == Schema Information
#
# Table name: paises
#
#  id         :integer          not null, primary key
#  nombre     :string(64)       not null
#  idioma_id  :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_paises_on_idioma_id  (idioma_id)
#  index_paises_on_nombre     (nombre) UNIQUE
#

class Pais < ActiveRecord::Base
  belongs_to :idioma
  has_many :empresas_forestales
  validates :nombre, presence: {message: 'Debe ingresar nombre de Pais'},
             uniqueness:{message: 'País ya ha sido creado'}

  validates :nombre,uniqueness:{message:'Otra Pais a sido registrado con este nombre.'},
            presence: { message: 'El campo Nombre es obligatorio'},
            :length => {  maximum: 64,
                          message:
                              'Nombre debe contener máximo 64 caracteres'
            }
end
