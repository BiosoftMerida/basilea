module DynamicSelect
  class DynamicSubcuencasController < ApplicationController
    respond_to :json

    def index
      bo = ActionController::Parameters.new(bo: params[:bo]).permit(:bo)[:bo]
      @unidad_manejo = UnidadManejo.where(bloque_ordenacion_id: bo)
      respond_with(@unidad_manejo)
    end
  end
end