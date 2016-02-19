class EmpresasController < ApplicationController
  before_action :set_empresa, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @empresas = Empresa.all
    respond_with(@empresas)
  end

  def show
    respond_with(@empresa)
  end

  def new
    @empresa = Empresa.new
    respond_with(@empresa)
  end

  def edit
  end

  def create
    @empresa = Empresa.new(empresa_params)
    respond_with(@empresa)
  end

  def update
    @empresa.update(empresa_params)
    respond_with(@empresa)
  end

  def destroy
    @empresa.destroy
    respond_with(@empresa)
  end

  private
    def set_empresa
      @empresa = Empresa.find(params[:id])
    end

    def empresa_params
      params.require(:empresa).permit(:nombre, :abreviado, :rif, :direccion_fiscal, :telefono, :pais_id)
    end
end
