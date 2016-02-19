module DynamicSelect
  class DynamicFisiografiaController < ApplicationController
    respond_to :json

    def paisaje
      paisajes = Paisaje.where(gran_paisaje_id: params[:gran_paisaje_id])
      render json: [paisajes: paisajes]
    end

    def sub_paisaje
      sub_paisajes = SubPaisaje.where(paisaje_id: params[:paisaje_id])
      render json: [sub_paisajes: sub_paisajes]
    end

  end
end