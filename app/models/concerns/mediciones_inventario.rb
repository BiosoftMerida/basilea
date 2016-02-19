module MedicionesInventario

  extend ActiveSupport::Concern

  def self.save_mediciones_inventario(params, user)
    parcela_inventario = ParcelaInventario.create_or_update(params.require(:parcela_manejo_id), parcela_inventario_params(params))
    medicion_parcela_inventario = parcela_inventario.create_or_update_medicion_inventario(medicion_params(params[:parcela_inventario]), params.require(:tipo_parcela_inventario))
    arboles_rows = params[:table_arboles_inventario_rowOrder].split(',')
    arboles_rows.each do |arbol_row|
      id = params["table_arboles_inventario_recordId_#{arbol_row}"]
      nro_cuadricula = params["table_arboles_inventario_numero_cuadricula_#{arbol_row}"]
      fi = params["table_arboles_inventario_fi_#{arbol_row}"]
      nro_arbol = params["table_arboles_inventario_nro_arbol_#{arbol_row}"]
      bi = params["table_arboles_inventario_bi_#{arbol_row}"]
      especie = params["table_arboles_inventario_especie_#{arbol_row}"]
      dap_cap = params["table_arboles_inventario_dap_cap_#{arbol_row}"]
      altura_fuste = params["table_arboles_inventario_altura_fuste_#{arbol_row}"]
      calidad = params["table_arboles_inventario_calidad_#{arbol_row}"]
      medicion_parcela_inventario.create_or_update_arbol(id, nro_cuadricula, fi, nro_arbol, bi, especie, dap_cap, altura_fuste, calidad, user.empresa_forestal_id,user)
    end
    return true
  end

  def self.delete_arbol_ajax(params, user)
    puts 'pase por delete arbol ajax'
    parcela = ParcelaInventario.find_by(parcela_manejo_id: params[:parcela_manejo_id]) || (return false)
    medicion_parcela_inventario = parcela.medicion_parcela_inventarios.find_by(tipo_parcela_inventario_id: params[:tipo_parcela]) || (return false)
    arbol = medicion_parcela_inventario.arbol_inventario_estaticos.find_by(nro_arbol: params[:nro_arbol], id: params[:id_arbol])
    puts arbol.inspect
    unless arbol.nil?
      arbol.destroy
      return true
    else
      return false
    end
    return false
  end

  def self.parcela_inventario_params(params)
    params.require(:parcela_inventario).permit(:coord_norte_utm, :coord_este_utm, :azimut)
  end

  def self.medicion_params(medicion_params)
    medicion_params.require(:medicion_parcela_inventario).permit(:fecha_inicio, :fecha_fin, :tecnico, :baquiano, :medicion_dap)
  end

end
