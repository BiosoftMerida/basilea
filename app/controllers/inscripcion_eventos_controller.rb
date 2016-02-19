class InscripcionEventosController < ApplicationController
  before_action :set_inscripcion_evento, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    evento = Evento.find_by(nombre: "Escuela de Influencia y Transformación")
    @inscripcion_eventos = evento.inscripcion_eventos.where(aceptado: nil).order(:fecha)
    respond_with(@inscripcion_eventos)
  end

  def show
    respond_with(@inscripcion_evento)
  end

  def new
    @inscripcion_evento = InscripcionEvento.new
    respond_with(@inscripcion_evento)
  end

  def edit
  end

  def create
    @inscripcion_evento = InscripcionEvento.new(inscripcion_evento_params)
    @inscripcion_evento.save
    respond_with(@inscripcion_evento)
  end

  def aprobar_preinscritos
    puts "ACEPTADOS Y RECHAZADOS"

    params[:aprobar_inscripcion].each do |f|
      puts "ID PREINSCRITO #{f[:id_inscripcion]} ACEPTADO #{f[:aceptado]}"
    end

    redirect_to root_url, notice: "La aprobación de los preinscritos se realizó satisfactoriamente y les fue enviado una notificación al correo"

  end

  def update
    @inscripcion_evento.update(inscripcion_evento_params)
    respond_with(@inscripcion_evento)
  end

  def destroy
    @inscripcion_evento.destroy
    respond_with(@inscripcion_evento)
  end

  private
    def set_inscripcion_evento
      @inscripcion_evento = InscripcionEvento.find(params[:id])
    end

    def inscripcion_evento_params
      params.require(:inscripcion_evento).permit(:fecha, :nro_asiento, :fecha_pago, :nro_pago, :monto, :aceptado, :fecha_aceptado, :contacto_id, :evento_id)
    end
end
