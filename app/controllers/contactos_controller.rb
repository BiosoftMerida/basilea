class ContactosController < ApplicationController
  before_action :set_contacto, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @contactos = Contacto.all
    respond_with(@contactos)

  end

  def show
    respond_with(@contacto)
  end

  def new
    @contacto = Contacto.new
    respond_with(@contacto)
  end

  def edit
  end

  # Crea el contacto y la preinscripción al evento "Escuela de Influencia y Transformación"
  def create
    @contacto = Contacto.new(contacto_params)
    if @contacto.save
        InscripcionEvento.create!(fecha: Date.today,evento: Evento.find_by(nombre: "Escuela de Influencia y Transformación"),
        contacto: Contacto.find_by(email: contacto_params[:email]))
    end
    respond_with(@contacto)
  end

  def update
    @contacto.update(contacto_params)
    respond_with(@contacto)
  end

  def destroy
    @contacto.destroy
    respond_with(@contacto)
  end

  private
    def set_contacto
      @contacto = Contacto.find(params[:id])
    end

    def contacto_params
      params.require(:contacto).permit(:nombres, :apellidos, :doc_identidad, :email, :telefono, :iglesia, :recomendado_por, :pais_id, :estado_id, :profesion_id, :ministerio_id, :empresa_id)
    end
end
