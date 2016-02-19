class PaisesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  #TODO AGREGAR ROLES

  # GET /pais
  # GET /pais.json
  def index
    @paises = Pais.all
  end

  # GET /pais/new
  def new
    @pais = Pais.new
  end

  # GET /pais/1/edit
  def edit
  end

  # POST /pais
  # POST /pais.json
  def create
    @pais = Pais.new(pais_params)

    respond_to do |format|
      if @pais.save
        format.html { redirect_to paises_path, notice: 'Pais creado existosamente.' }
        format.json { render :index, status: :created, location: @pais }
      else
        format.html { render :new }
        format.json { render json: @pais.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pais/1
  # PATCH/PUT /pais/1.json
  def update
    respond_to do |format|
      if @pais.update(pais_params)
        format.html { redirect_to paises_path, notice: 'Pais actualizado exitosamente.' }
        format.json { render :index, status: :ok, location: @pais }
      else
        format.html { render :edit }
        format.json { render json: @pais.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pais/1
  # DELETE /pais/1.json
  def destroy
    @pais.destroy
    respond_to do |format|
      format.html { redirect_to paises_url, notice: 'Pais se ha eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def pais_params
      params.require(:pais).permit(:nombre, :idioma_id, :moneda_id)
    end
end
