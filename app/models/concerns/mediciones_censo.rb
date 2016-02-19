module MedicionesCenso

  extend ActiveSupport::Concern

  def self.save_mediciones_censo(params, user)
    parcela = ParcelaManejo.find_by(id: params.require(:parcela_manejo_id))
    parcela_id = parcela.id
    parcela.update(parcela_manejo_params(params))
    arboles_rows = params[:table_arboles_censo_rowOrder].split(',')
    arboles_rows.each do |arbol_row|
      id = params["table_arboles_censo_recordId_#{arbol_row}"]
      nro_arbol = params["table_arboles_censo_nro_arbol_#{arbol_row}"]
      fi_p = params["table_arboles_censo_fi_p_#{arbol_row}"]
      fi_sp = params["table_arboles_censo_fi_sp_#{arbol_row}"]
      puts fi_sp.inspect
      cp = params["table_arboles_censo_candidato_#{arbol_row}"]
      especie = params["table_arboles_censo_especie_#{arbol_row}"]
      dap_cap = params["table_arboles_censo_dap_cap_#{arbol_row}"]
      altura_fuste = params["table_arboles_censo_altura_fuste_#{arbol_row}"]
      altura_total = params["table_arboles_censo_altura_total_#{arbol_row}"]
      utm_norte = params["table_arboles_censo_utm_norte_#{arbol_row}"]
      utm_este = params["table_arboles_censo_utm_este_#{arbol_row}"]
      calidad = params["table_arboles_censo_calidad_#{arbol_row}"]
      vitalidad = params["table_arboles_censo_vitalidad_#{arbol_row}"]
      MedicionesCenso.create_or_update_arbol_censo(id, nro_arbol, fi_p, fi_sp, cp, especie, dap_cap, altura_fuste, altura_total, utm_norte, utm_este, calidad, vitalidad, parcela_id, user.empresa_forestal_id,user)
    end
    return true
  end

  def self.delete_arbol_ajax(params, user)
    arbol = ArbolCenso.find_by(nro_arbol: params[:nro_arbol], id: params[:id_arbol], parcela_manejo_id: params[:parcela_id])
    unless arbol.nil?
      arbol.destroy
      return true
    else
      return false
    end
    return false
  end

  def self.create_or_update_arbol_censo(id, nro_arbol, fi_p, fi_sp, cp, especie, dap_cap, altura_fuste, altura_total, utm_norte, utm_este, calidad, vitalidad, parcela_id, empresa_forestal_id,user)
    sp = SubPaisaje.where( paisaje_id: fi_p, nombre: fi_sp)
    ca = ArbolCenso.tipo_calidad_fustes[calidad.to_sym].to_i
    vi = ArbolCenso.tipo_vitalidad_copas[vitalidad.to_sym].to_i
    parcela = ParcelaManejo.find(parcela_id)
    dap = parcela.medicion_dap_censo ? dap_cap.to_f : (dap_cap.to_f / Math::PI)
    area_basal = (Math::PI / 4) * (dap/100) * (dap/100)
    eq_volumen = EcuacionVolumen.get_ecuacion_volumen(dap,user.unidad_manejo.tipo_bosque_id)
    volumen = Dentaku(eq_volumen, d: dap/100, h: altura_fuste.to_f)
    especie = Especie.find_by(nombre_comun: especie, empresa_forestal_id: empresa_forestal_id) ||
        Especie.create(nombre_comun: especie, empresa_forestal_id: empresa_forestal_id)

    if id == ''
      ArbolCenso.create( nro_arbol: nro_arbol, candidato: cp, dap: dap,
                         altura_fuste: altura_fuste.to_f, altura_total: altura_total.to_f,
                         utm_norte: utm_norte, utm_este: utm_este,
                         tipo_calidad_fuste: ca, tipo_vitalidad_copa: vi,
                         especie: especie,volumen: volumen, area_basal: area_basal,
                         sub_paisaje_id: sp[0][:id], parcela_manejo_id: parcela_id)
    else
      arbol = ArbolCenso.find(id)
      arbol.update(id: id, nro_arbol: nro_arbol, candidato: cp, dap: dap,altura_fuste: altura_fuste.to_f,
                   altura_total: altura_total.to_f, utm_norte: utm_norte, utm_este: utm_este,
                   tipo_calidad_fuste: ca, tipo_vitalidad_copa: vi, especie: especie,volumen: volumen, area_basal: area_basal, sub_paisaje_id: sp[0][:id])
    end
  end

  def self.parcela_manejo_params(params)
    params.require(:parcela_manejo).permit(:fecha_inicio_censo, :fecha_fin_censo, :tecnico_censo, :baquiano_censo, :medicion_dap_censo, :coordinador_censo)
  end


end
