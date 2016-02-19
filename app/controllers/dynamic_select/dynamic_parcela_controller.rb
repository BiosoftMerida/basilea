module DynamicSelect
  class DynamicParcelaController < ApplicationController
    respond_to :json

    def index
      unidad_manejo_id = current_user.unidad_manejo.id
      @parcelas_inventario = ParcelaInventario.get_parcelas_tpi(unidad_manejo_id, params[:tipo_parcela_inventario_id])
      @np = @parcelas_inventario.sort_by {|n| n[:id]}
      render json: [parcelas_inventario: @np]
    end
  end
end