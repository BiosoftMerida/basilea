class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  #protect_from_forgery with: :exception

  include ManageDocumentHelper

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = 'Usted no esta autorizado para acceder a la página solicitada.'
    redirect_to root_path
  end

  protected
    def self.permission
      self.name.gsub('Controller','').singularize.split('::').last.constantize.name rescue nil
    end

    def current_ability
      @current_ability ||= Ability.new(current_user)
    end

    def load_permissions
      @current_permissions = current_user.roles.each do |role|
        role.permissions.collect{|i| [i.subject_class, i.action]}
      end
    end

    def set_user
      @user = User.find_by(id: ActionController::Parameters.new(id: params[:id]).permit(:id)[:id])
    end

    def user_params
      params.require(:user).permit(:name, :username, :email, :password, :locked, :empresa_forestal_id, :cellphone, :role_id)#, rol_ids: [])
    end

    def params_id
      ActionController::Parameters.new(id: params[:id]).permit(:id)[:id]
    end

    def check_user_empresa
      if current_user.empresa_id.nil?
        redirect_to root_path, alert: 'Usted como administrador debe estar asociado a una institución para ingresar a esta página.'
      end
    end
end
