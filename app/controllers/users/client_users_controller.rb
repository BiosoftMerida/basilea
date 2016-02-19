class Users::ClientUsersController < ApplicationController
  before_action :authenticate_user!
  authorize_resource class: :client_users
  before_action :set_user, only: [:destroy, :show, :edit, :update]
  before_action :set_roles, only: [:new, :edit]
  before_action :check_user_empresa
  @@password = ""

  def index
    @users = User.joins(:role).where(empresa_id: current_user.empresa.id, roles: {role_type: Role.role_types[:cliente]})
  end

  def new
    @user ||= User.new
  end

  def create
    @user = User.new(client_user_params.merge(empresa_id: current_user.empresa.id))
    @@password = client_user_params[:password]
    respond_to do |format|
      if @user.save
        PasswordMailer.send_password(@user, @@password).deliver
        format.html { redirect_to  client_user_path(@user), notice: 'El usuario se ha creado exitosamente.' }
        format.json { render :show, status: :created, location: @user }
      else
        set_roles
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @pass = @@password
    @@password = ""
  end

  def destroy
    if @user.empresa.id == current_user.empresa.id && (@user.role.cliente?)
      if @user.destroy
        redirect_to client_users_path, alert: 'Usuario eliminado satisfactoriamente.' and return
      end
    else
      redirect_to client_users_path, alert: 'No Autorizado' and return
    end
  end

  def edit

  end

  def update
    if @user.empresa.id == current_user.empresa.id && @user.role.cliente?
      respond_to do |format|
        if @user.update(client_user_params)
          format.html { redirect_to client_user_path(@user), notice: 'El usuario ha sido actualizado.' }
          format.json { render :show, status: :ok, location: @user }
        else
          set_roles
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to client_users_path, alert: 'No Autorizado' and return
    end
  end

  private
  def client_user_params
    params.require(:user).permit(:name, :username, :email, :password, :cellphone, :role_id, :locked)
  end

  def self.permission
    'client_users'
  end

  def set_roles
    @roles = Role.where(role_type: Role.role_types[:cliente])
    if @roles.blank?
      redirect_to new_role_path, alert: 'No existen roles para Clientes de Empresas Forestales.' and return
    end
  end
end