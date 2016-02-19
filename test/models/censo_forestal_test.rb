require 'test_helper'

class CensoForestalTest < ActiveSupport::TestCase
  # Probando el metodo get_cuota_explotacion(arboles)
  test "metodo get_cuota_explotacion c1" do
    masa_forestal = CensoForestal.get_cuota_explotacion([])
    assert_equal([],masa_forestal,"Error:La masa forestal del censo  no cumplen con el criterio 1")
  end
  test "metodo get_cuota_explotacion c2" do
    masa_forestal = CensoForestal.get_cuota_explotacion(ArbolCenso.all)
    assert_equal([{:nombre_comun=>"cedro",:nombre_cientifico=>nil,:num_arboles=>3,:area_basal=>1.50,:volumen=>1.86,:num_arboles_padres=>0},
                  {:nombre_comun=>"guamo",:nombre_cientifico=>nil,:num_arboles=>5,:area_basal=>1.70,:volumen=>2.0,:num_arboles_padres=>0},
                  {:nombre_comun=>"hierrito",:nombre_cientifico=>nil,:num_arboles=>6,:area_basal=>3.90,:volumen=>4.56,:num_arboles_padres=>3},
                  {:nombre_comun=>"purgo",:nombre_cientifico=>nil,:num_arboles=>4,:area_basal=>2.80,:volumen=>3.22,:num_arboles_padres=>0}],
                 masa_forestal,"Error:La masa forestal del censo  no cumplen con el criterio 2")
  end

  # OJO: PENDIENTE DE LAS PRUEBAS DE LOS DEMAS METODOS

end
