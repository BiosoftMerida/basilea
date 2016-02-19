module MasaForestal

  extend ActiveSupport::Concern
  require 'descriptive_statistics'

  # Método: get_masa_forestal. Obtiene la masa forestal (densidad, area_basal, dap, altura_fuste, volumen y abundancia efectiva) por diferentes criterios
  # Entrada:
  #   arboles: ArbolInventarioEstatico. Es el conjunto de arboles de inventario estatico
  #   criterio: string. Indica si la masa forestal es por: "parcela" o "especie" o "grespecie" o "calidad"
  # Salida
  #   mf_xcriterio: array of hash. La masa forestal que contiene: criterio, dens, area_basal, dap, altura, volumen y abundancia efectiva
  def self.get_masa_forestal(arboles,criterio)
    # valida los parámetros de entrada
    if (!['parcela', 'especie', 'grespecie','calidad'].include?(criterio) || arboles.empty?)
      return []
    end
     mf_xcriterio = Array.new
    case criterio
      when "parcela"
        mf_xarbol = arboles.select("medicion_parcela_inventario_id,count(*) as nro_arbol,sum(area_basal) as area_basal,sum(dap)/count(*) as dap,sum(altura_fuste)/count(*) as altura_fuste,sum(volumen) as volumen").group(:medicion_parcela_inventario_id).order(:medicion_parcela_inventario_id)
        ae_xcriterio = arboles.select("medicion_parcela_inventario_id,count(distinct(nro_cuadricula)) as nro_cuadricula").group(:medicion_parcela_inventario_id).order(:medicion_parcela_inventario_id)
      when "calidad"
        mf_xarbol = arboles.select("tipo_calidad_fuste,count(*) as nro_arbol,sum(area_basal) as area_basal,sum(dap)/count(*) as dap,sum(altura_fuste)/count(*) as altura_fuste,sum(volumen) as volumen").group(:tipo_calidad_fuste).order(:tipo_calidad_fuste)
        ae_xcriterio = arboles.select("tipo_calidad_fuste,count(distinct(nro_cuadricula)) as nro_cuadricula").group(:tipo_calidad_fuste).order(:tipo_calidad_fuste)
      else
        mf_xarbol = arboles.select("especie_id,count(*) as nro_arbol,sum(area_basal) as area_basal,sum(dap)/count(*) as dap,sum(altura_fuste)/count(*) as altura_fuste,sum(volumen) as volumen").group(:especie_id).order(:especie_id)
        ae_xcriterio = arboles.select("especie_id,count(distinct(nro_cuadricula)) as nro_cuadricula").group(:especie_id).order(:especie_id)
    end
    i = 0
    mf_xarbol.each { |arbol|
      case criterio
        when "parcela"
          valor_criterio = arbol.medicion_parcela_inventario.parcela_inventario.parcela_manejo.codigo
        when "especie"
          valor_criterio = arbol.especie.nombre_comun
        when "grespecie"
          valor_criterio = arbol.especie.grupo_especie.nombre
          puts valor_criterio.inspect
        when "calidad"
          valor_criterio = arbol.tipo_calidad_fuste
      end
      masa_forestal = {criterio: valor_criterio,densidad: arbol.nro_arbol, area_basal: arbol.area_basal,dap: arbol.dap,altura_fuste: arbol.altura_fuste,volumen: arbol.volumen, abundancia_efectiva: ae_xcriterio[i].nro_cuadricula}
      mf_xcriterio << masa_forestal
      i = i + 1
    }
    if criterio == "grespecie"
      mf_xgrespecie = mf_xcriterio.group_by { |x| x.values_at(:criterio) }.map {|key, hashes|
        result = hashes[0].clone
        [:densidad,:area_basal,:dap,:altura_fuste,:volumen,:abundancia_efectiva].each { |key|
          result[key] = hashes.inject(0) { |s, x| s + x[key] }
        }
        result
        # puts result.inspect
      }
      return mf_xgrespecie
    else
      return mf_xcriterio
    end
  end

  # Método: get_estadisticas_mf: Obtiene las estadísticas (prom, varianza, desviación típica, coef_variación
  #   error de la media, error de muestreo y límites de confianza)de la masa forestal para las siguientes variables: densidad, area_basal, dap, altura_fuste y volumen
  # Entrada:
  #   mf_xparcela:array of hash, que contiene: criterio, dens, area_basal, dap, altura, volumen y abundancia efectiva
  #   nivel_confianza: string. Los posibles valores son: '90%', '95%' y '99%'
  # Salida
  #   estadisticas_mf: array of hash. Las estadísticas de la masa forestal
  def self.get_estadisticas_mf(mf_xparcela,nivel_confianza)

    # valida los parámetros de entrada
    if (!['90%', '95%', '99%'].include?(nivel_confianza) || mf_xparcela.empty?)
      return []
    end
    n         = mf_xparcela.length-1
    t_student = Tstudent.get_t_student(n,nivel_confianza)

    estadisticas_mf = []
    ['densidad','area_basal','dap','altura_fuste','volumen'].each  { |var_mf|
      case var_mf
        when 'densidad'
          array_var_mf  = mf_xparcela.map {|x| x[:densidad]}
        when 'area_basal'
          array_var_mf  = mf_xparcela.map {|x| x[:area_basal]}
        when 'dap'
          array_var_mf  = mf_xparcela.map {|x| x[:dap]}
        when 'altura_fuste'
          array_var_mf  = mf_xparcela.map {|x| x[:altura_fuste]}
        when 'volumen'
          array_var_mf  = mf_xparcela.map {|x| x[:volumen]}
      end
      promedio            = array_var_mf.mean
      varianza            = array_var_mf.variance
      desv_tipica         = array_var_mf.standard_deviation
      coef_variacion      = promedio == 0? 100 : desv_tipica/promedio
      error_media         = desv_tipica/Math::sqrt(n)
      error_muestreo      = error_media * t_student
      error_muestreo_porc = promedio == 0 ? 100: error_muestreo/promedio * 100
      lim_inf_conf        = promedio - error_muestreo
      lim_sup_conf        = promedio + error_muestreo

      estadisticas_mf << {variable: var_mf,promedio: promedio,variaza: varianza,desv_tipica: desv_tipica,
                          coef_variacion: coef_variacion,error_media: error_media,error_muestreo: error_muestreo,
                          error_muestreo_porc: error_muestreo_porc,lim_inf_conf: lim_inf_conf,lim_sup_conf: lim_sup_conf}
    }
    return estadisticas_mf,n
  end

  # Método: get_masa_forestal_xcd. Obtiene la masa forestal (densidad, area_basal, dap, altura_fuste y volumen) por categorías diamétricas (rangos de dap)
  # Entrada:
  #   arboles: ArbolInventarioEstatico. Es el conjunto de arboles de inventario estatico
  #   amplitud_cd: integer. Es la amplitud de la categoría diamétrica
  # Salida
  #   mf_xcd: array of hash. La masa forestal que contiene: dap inicial, dap final, densidad, area_basal y volumen
  def self.get_masa_forestal_xcd(arboles,amplitud_cd)
    # valida los parámetros de entrada
    if (arboles.empty? || amplitud_cd <= 0)
      return {}
    end
    mf_xcd = Array.new
    arboles_odap = arboles.order(:dap)
    dap_inicio = Integer(arboles_odap[0].dap)
    dap_final  = dap_inicio + amplitud_cd
    i = 0
    len_arboles = arboles.count-1
    while i <= len_arboles do
      dens = ab = vol = 0
      while (Integer(arboles_odap[i].dap) >= dap_inicio && Integer(arboles_odap[i].dap) < dap_final)  do
        dens += 1
        ab   += arboles_odap[i].area_basal
        vol  += arboles_odap[i].volumen
        i    += 1
        break if i > len_arboles
      end
      mf = {dap_inicio: dap_inicio,dap_final: dap_final,densidad: dens, area_basal: ab,volumen: vol}
      dap_inicio  = dap_final
      dap_final  += amplitud_cd
      mf_xcd << mf
    end
    return mf_xcd
  end



  # Método: get_matriz_adrd: Obtiene la matriz ADRD
  # Entrada: arboles: ArbolInventarioEstatico
  #          variable_mf: string: "densidad" o "area_basal" o "volumen"
  # Salidad: Matriz ADRD: Hash of array. Ejemplo: Si variable_mf="densidad", matriz_adrd = {:A=>[6,5,4,3,1,0,0,0,0],:AuB=>[8,7,6,4,3,2,0,0,0], etc
  def self.get_matriz_adrd(arboles,variable_mf)
    puts variable_mf.inspect
    # valida los parámetros de entrada
    if (!['densidad', 'area basal', 'volumen', 'abundancia efectiva'].include?(variable_mf) || arboles.empty?)
      return {}
    end
    array_ef = GrupoEspecie.get_especificacion_floristica    # ["A","AuB","AuBuC]
    hash_ids_especies = Especie.get_ids_especies_xef         # {:A=>[1,3], :AuB=>[1,2,3], :AuBuC=>[1,3,2,6]}
    matriz_adrd = Hash.new
    ed = [10,15,20,25,30,35,40,45,50]                              # Espeficación diamétrica
    for i in 0..array_ef.length-1
      masa_forestal_ed = [0,0,0,0,0,0,0,0,0]
      ef = array_ef[i]
      ids_especies = hash_ids_especies[ef]

      arboles_ef = arboles.where(especie_id: ids_especies)

      if !arboles_ef.blank?
        arboles_ef.each do |arbol|
          for j in 0..ed.length-1
            case variable_mf
              when "densidad"
                masa_forestal_ed[j] += arbol.dap > ed[j]? 1 : 0
              when "area basal"
                masa_forestal_ed[j] += arbol.dap > ed[j]? arbol.area_basal : 0
              else
                masa_forestal_ed[j] += arbol.dap > ed[j]? arbol.volumen : 0
            end
          end
        end
      end
      matriz_adrd[ef] = masa_forestal_ed
    end
    return matriz_adrd
  end


end
