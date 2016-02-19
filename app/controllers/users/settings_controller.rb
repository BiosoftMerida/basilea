class Users::SettingsController < ApplicationController
  before_action :authenticate_user!


  def index
  end

  def update_subcuenca
  end

  def unidad_manejo
  end

  def save_subcuenca

    if params_id != "" and current_user.update(unidad_manejo_id: params_id)
      render json: true
    else
      render json: false
    end
  end
end