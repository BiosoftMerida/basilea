# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  email                  :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  unique_session_id      :string(20)
#  role_id                :integer
#  name                   :string(255)
#  cellphone              :string(255)
#  avatar                 :string(255)
#  locked                 :boolean          default(FALSE)
#  empresa_forestal_id    :integer
#  created_at             :datetime
#  updated_at             :datetime
#  unidad_manejo_id       :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_empresa_forestal_id   (empresa_forestal_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_role_id               (role_id)
#  index_users_on_unidad_manejo_id      (unidad_manejo_id)
#  index_users_on_username              (username) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :registerable, :recoverable,
          :rememberable, :trackable, :validatable, :session_limitable

  devise :database_authenticatable,:authentication_keys => [:username]

  mount_uploader :avatar, AvatarUploader

  belongs_to :role
  belongs_to :empresa

  validates :username, presence: {message: 'es obligatorio'},
            uniqueness: {message: 'ya en uso.'}
  validates :email, presence: {message: 'Obligatorio'}
  validates :name, presence: {message: 'Obligatorio'}
  validates :role_id, presence: {message: 'Obligatorio'}
  #validate :admin

  def admin
    if Role.find_by(id: role_id) != Role.where(name: 'Super Usuario').first
      if empresa_id.nil?
        errors.add(:empresa_id, "Debe asignar una empresa al usuario")
      end
    end
  end

  def self.administradores_clientes
    User.joins(:role).where(roles: {role_type: Role.role_types[:administrador_cliente]})
  end



end
