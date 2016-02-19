class Empresa < ActiveRecord::Base
  include RegexHelper

  #asociaciones
  belongs_to :pais
  has_many :users
  has_many :eventos
  has_many :contactos
  accepts_nested_attributes_for :pais



  #validates field
  validates :nombre, uniqueness: {message:'Otra Empresa a sido registrada con este nombre.'},
            presence: { message: 'El campo Nombre es obligatorio'},
            :length => {  maximum: 64,
                          message:
                              'Nombre debe contener máximo 64 caracteres'
            }
  validates :abreviado, uniqueness: {message:'Otra Empresa a sido registrada con este Abreviado.'},
            presence: { message: 'El campo Abreviado es obligatorio'}
  validates :rif, uniqueness:{message:'Otra Empresa a sido registrada con este RIF.'},
            presence: { message: 'El campo RIF es obligatorio'}
  validates :direccion_fiscal, presence: { message: 'El campo Dirección es obligatorio'}
  validates :telefono ,uniqueness:{message:'Otra Empresa a sido registrada con este Teléfono.'},
            presence: {message: 'El campo Teléfono es obligatorio'}



  #callbacks definition
  def convert_format
    self.rif= self.rif.gsub(/-/,'')
    self.telefono = self.telefono.gsub(/[\(\)\- ]/,'')
  end
  #helps methods

  def self.without_admin
    return Empresa.where(id: Empresa.joins(:users).merge(User.joins(:role).where(roles: {role_type: Role.role_types[:administrador_cliente]})))
  end

  def safe_to_delete
    if self.users.any?
      return false
    else
      return true
    end
  end

end
