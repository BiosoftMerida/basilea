module CensoForestal

  extend ActiveSupport::Concern

  # Método: get_cuota_explotacion. Obtiene la cuota de explotación, en términos de masa forestal (num arboles, area_basal, volumen y árboles padres)
  # Entrada:
  #   arboles: ArbolCenso. Es el conjunto de arboles del censo forestal
  # Salida
  #   masa_forestal: array of hash. La masa forestal que contiene: especie(nombre común y científico), num árboles, area_basal, volumen y árboles padres
  def self.get_cuota_explotacion(arboles)
    # valida los parámetros de entrada
    if arboles.empty?
      return []
    end
    masa_forestal = Array.new
    mf_xespecie = arboles.select("especie_id,count(*) as nro_arbol,sum(case candidato when true then 1 else 0 end) as id,sum(area_basal) as area_basal,sum(volumen) as volumen")
                  .group(:especie_id)
    mf_xespecie.each { |arbol|
      masa_forestal << {nombre_comun: arbol.especie.nombre_comun,
                        nombre_cientifico: arbol.especie.nombre_cientifico,
                        num_arboles: arbol.nro_arbol,
                        area_basal: arbol.area_basal,
                        volumen: arbol.volumen,
                        num_arboles_padres: arbol.id}
    }

    return masa_forestal.sort_by {|m| m[:nombre_comun] }
  end


  # Método: get_control_tumba. Obtiene la información de control de tumba (bloque, parcela, especie, mf aprovechable, mf de padres y mf total)
  # Entrada:
  #   arboles: ArbolCenso. Es el conjunto de arboles del censo forestal
  # Salida
  #   masa_forestal: array of hash. La masa forestal que contiene: bloque, parcela, especie, arb y volumen aprovechable, arb y volumen de padres y arb y volumen total
  def self.get_control_tumba(arboles)
    # valida los parámetros de entrada
    if arboles.empty?
      return []
    end
    masa_forestal = Array.new
    select = "bloque_manejo_id,codigo,especie_id,
             sum(case candidato when false then 1 else 0 end) as arb_aprov,
             sum(case candidato when false then volumen else 0 end) as vol_aprov,
             sum(case candidato when true then 1 else 0 end) as arb_padres,
             sum(case candidato when true then volumen else 0 end) as vol_padres,
             count(nro_arbol) as arb_totales,sum(volumen) as vol_total"

    mf_xbloque_xparc_xespecie = arboles.joins(:parcela_manejo)
      .select(select).group(:bloque_manejo_id,:codigo,:especie_id)
      .collect{|mf| {codigo_bloque: BloqueManejo.find(mf.bloque_manejo_id).codigo,
                     codigo_parcela: mf.codigo,
                     especie: Especie.find(mf.especie_id).nombre_comun,
                     arb_aprov: mf.arb_aprov,vol_aprov: mf.vol_aprov,arb_padres: mf.arb_padres,vol_padres: mf.vol_padres,
                     arb_totales: mf.arb_totales,vol_total: mf.vol_total  } }

    return mf_xbloque_xparc_xespecie

    #return masa_forestal.sort_by {|m| m[:nombre_comun] }
  end

  # Método: get_mf_xbloque. Obtiene la masa forestal (num arboles, num especies, area_basal y volumen) para cada bloque de manejo (aprovechamiento)
  # Entrada:
  #   arboles: ArbolCenso. Es el conjunto de arboles del censo forestal
  # Salida
  #   masa_forestal: array of hash. La masa forestal que contiene: Num árboles, Num especies, area_basal y volumen
  def self.get_mf_xbloque(arboles)
    # valida los parámetros de entrada
    if arboles.empty?
      return []
    end
    masa_forestal = Array.new
    mf_xbloque = arboles.joins(:parcela_manejo)
                  .select("bloque_manejo_id,count(*) as num_arboles,count(distinct(especie_id)) as num_especies,sum(area_basal) as area_basal,sum(volumen) as volumen")
                  .group(:bloque_manejo_id)
                  .collect{|mf| {bloque_id: mf.bloque_manejo_id,num_arboles: mf.num_arboles,num_especies: mf.num_especies,area_basal: mf.area_basal,volumen: mf.volumen} }

    mf_xbloque.each { |mf|
      masa_forestal << {codigo: BloqueManejo.find(mf[:bloque_id]).codigo,
                        num_arboles: mf[:num_arboles],num_especies: mf[:num_especies],area_basal: mf[:area_basal],volumen: mf[:volumen]}
    }
    return masa_forestal.sort_by {|m| m[:codigo] }

  end


  # Método: get_mf_subcuenca. Obtiene la masa forestal (num arboles, area_basal, volumen ) para toda la UPA o subcuenca
  # Entrada:
  #   arboles: ArbolCenso. Es el conjunto de arboles del censo forestal
  # Salida
  #   masa_forestal: array of hash. La masa forestal que contiene: especie(nombre común y científico),  num árboles, area_basal, volumen, arbol promedio y promedio x hectárea
  def self.get_mf_subcuenca(arboles,area_subcuenca)
    # valida los parámetros de entrada
    if arboles.empty?
      return []
    end
    masa_forestal = arboles.select("especie_id,
                                sum(case candidato when false then 1 else 0 end) as narb_aprov,
                                sum(case candidato when false then area_basal else 0 end) as ab_aprov,
                                sum(case candidato when false then volumen else 0 end) as vol_aprov,
                                sum(case candidato when true then 1 else 0 end) as narb_padres,
                                sum(case candidato when true then area_basal else 0 end) as ab_padres,
                                sum(dap)/count(*) as dap_prom,
                                sum(altura_fuste)/count(*) as altura_prom,
                                sum(volumen)/count(*) as vol_prom,
                                count(*) as narb,
                                sum(volumen) as vol")
                                .group(:especie_id)
                                .collect{|a| {nombre_comun: Especie.find(a.especie_id).nombre_comun,
                                              narb_aprov: a.narb_aprov,ab_aprov: a.ab_aprov,vol_aprov:
                                              a.vol_aprov,narb_padres: a.narb_padres,ab_padres: a.ab_padres,
                                              dap_prom: a.dap_prom,altura_prom: a.altura_prom,vol_prom: a.vol_prom,
                                              narb_prom_ha: a.narb/area_subcuenca,
                                              vol_prom_ha: a.vol/area_subcuenca}}


    return masa_forestal.sort_by {|m| m[:nombre_comun] }
  end


  # Método: get_mf_xfisiografía. Obtiene la masa forestal (num arboles, num especies, area_basal y volumen) para cada tipo de fisiografía
  # Entrada:
  #   arboles: ArbolCenso. Es el conjunto de arboles del censo forestal
  # Salida
  #   masa_forestal: array of hash. La masa forestal que contiene: Num árboles, Num especies, area_basal y volumen
  def self.get_mf_xfisiografia(arboles)
    # valida los parámetros de entrada
    if arboles.empty?
      return []
    end
    masa_forestal = Array.new
    mf_xbloque = arboles.select("sub_paisaje_id,count(*) as num_arboles,count(distinct(especie_id)) as num_especies,sum(area_basal) as area_basal,sum(volumen) as volumen")
    .group(:sub_paisaje_id)
    .collect{|mf| {sub_paisaje_id: mf.sub_paisaje_id,num_arboles: mf.num_arboles,num_especies: mf.num_especies,area_basal: mf.area_basal,volumen: mf.volumen} }

    mf_xbloque.each { |mf|
      sub_paisaje = SubPaisaje.find(mf[:sub_paisaje_id])
      masa_forestal << {gran_paisaje: sub_paisaje.paisaje.gran_paisaje.nombre,
                        paisaje: sub_paisaje.paisaje.nombre,
                        sub_paisaje: sub_paisaje.nombre,
                        num_arboles: mf[:num_arboles],num_especies: mf[:num_especies],area_basal: mf[:area_basal],volumen: mf[:volumen]}
    }
    return masa_forestal.sort_by {|m| m[:gran_paisaje] }

  end



  # Método: get_mf_xcd_xespecie: Obtiene la masa forestal x categorías diamétricas y por especie
  # Entrada: arboles: ArbolInventarioEstatico
  #          variable_mf: string: "número de arboles" o "area basal" o "volumen"
  # Salidad: mf_xcd_xespecie: Hash of array. Ejemplo: Si variable_mf="número de arboles", mf_xcd_xespecie = {:puy=>[6,5,4,3,1,0,0,0,0],:algarrobo=>[8,7,6,4,3,2,0,0,0], etc
  def self.get_mf_xcd_xespecie(arboles,variable_mf)
    # valida los parámetros de entrada
    if (!['número de arboles', 'area basal', 'volumen'].include?(variable_mf) || arboles.empty?)
      return {}
    end
    arboles_xespecie = arboles.order(:especie_id)
    cd = [40,50,60,70,80,90,100,110,120,999]
    mf_xcd_xespecie = {}
    mf_total = [0,0,0,0,0,0,0,0,0,0]
    i = 0
    len_arboles = arboles_xespecie.count-1
    while i <= len_arboles do
      mf_cd = [0,0,0,0,0,0,0,0,0,0]
      especie_id = arboles_xespecie[i].especie_id
      while (arboles_xespecie[i].especie_id == especie_id)  do
        for j in 0..cd.length-2
          case variable_mf
            when "número de arboles"
              mf_cd[j] += (arboles_xespecie[i][:dap] >= cd[j] && arboles_xespecie[i][:dap] < cd[j+1])? 1 : 0
            when "area basal"
              mf_cd[j] += (arboles_xespecie[i][:dap] >= cd[j] && arboles_xespecie[i][:dap] < cd[j+1])? arboles_xespecie[i][:area_basal] : 0
            else
              mf_cd[j] += (arboles_xespecie[i][:dap] >= cd[j] && arboles_xespecie[i][:dap] < cd[j+1])? arboles_xespecie[i][:volumen] : 0
          end
        end
        i    += 1
        break if i > len_arboles
      end
      # obtiene el total de la especie
      mf_cd[9] = mf_cd.inject{|sum,x| sum + x}
      # totaliza para cada cd
      for j in 0..mf_total.length-1
        mf_total[j] += mf_cd[j]
      end
      especie = Especie.find(especie_id).nombre_comun
      mf_xcd_xespecie[especie] = mf_cd
    end
    mf_xcd_xespecie['Total'] = mf_total
    return mf_xcd_xespecie
  end

end
