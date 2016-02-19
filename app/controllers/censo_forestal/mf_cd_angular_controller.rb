class CensoForestal::MfCdAngularController < ApplicationController

  before_action :authenticate_user!

  include CensoForestal

  respond_to :json

  def index
    @bloques = BloqueManejo.get_bloques_subcuenca(current_user.unidad_manejo_id)
  end

  def wf_mf_cd_especie
    puts "estoy en el controlador del servidor acción procesar"
    puts "El bloque es: #{ params[:bloque_manejo_id]}"
    puts "La vm es: #{params[:variable_mf]}"


    bloque_manejo_id = params[:bloque_manejo_id]
    variable_mf = params[:variable_mf].downcase



    ids_parcelas = ParcelaManejo.get_ids_parcelas_xbloque(current_user.unidad_manejo_id,bloque_manejo_id)
    arboles = ArbolCenso.get_arboles(ids_parcelas,0)

    mf_xcd_xespecie = CensoForestal.get_mf_xcd_xespecie(arboles,variable_mf)

    # formatear datos decimales
    if ['area basal', 'volumen'].include?(variable_mf)
      mf_xcd_xespecie.each do  |key, mf|
        for i in 0..9
          mf[i] = ActionController::Base.helpers.number_to_currency(mf[i], precision: 3,separator: ',', delimiter: '.', format: "%n %u", unit: "")
        end
      end
    end

    puts mf_xcd_xespecie

    #render json: [masa_forestal: mf_xcd_xespecie]

    render json: mf_xcd_xespecie

  end

  def self.permission
    :wf_mf_cd_especie
  end
end



