module DynamicSelect
  class DynamicUnidadOrdenacionController < ApplicationController
    respond_to :json

    def index
      @unidad_ordenacion = UnidadOrdenacion.where(reserva_forestal_id: params[:reserva_forestal_id])
      respond_with(@unidad_ordenacion)
    end
  end
end