class EventosController < ApplicationController
  before_action :set_evento, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @eventos = Evento.all
    respond_with(@eventos)
  end

  def show
    respond_with(@evento)
  end

  def new
    @evento = Evento.new
    respond_with(@evento)
  end

  def edit
  end

  def create
    @evento = Evento.new(evento_params)
    @evento.save
    respond_with(@evento)
  end

  def update
    @evento.update(evento_params)
    respond_with(@evento)
  end

  def destroy
    @evento.destroy
    respond_with(@evento)
  end

  private
    def set_evento
      @evento = Evento.find(params[:id])
    end

    def evento_params
      params.require(:evento).permit(:nombre, :descripcion, :fecha_inicio, :fecha_fin, :tlf_contacto, :email_contacto, :cupos, :lugar, :horario, :precio, :servicios, :mensaje_invitacion, :empresa_id)
    end
end
