require "test_helper"

class EmpresasControllerTest < ActionController::TestCase
  def empresa
    @empresa ||= empresas :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:empresas)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference("Empresa.count") do
      post :create, empresa: { abreviado: empresa.abreviado, direccion_fiscal: empresa.direccion_fiscal, nombre: empresa.nombre, pais_id: empresa.pais_id, rif: empresa.rif, telefono: empresa.telefono }
    end

    assert_redirected_to empresa_path(assigns(:empresa))
  end

  def test_show
    get :show, id: empresa
    assert_response :success
  end

  def test_edit
    get :edit, id: empresa
    assert_response :success
  end

  def test_update
    put :update, id: empresa, empresa: { abreviado: empresa.abreviado, direccion_fiscal: empresa.direccion_fiscal, nombre: empresa.nombre, pais_id: empresa.pais_id, rif: empresa.rif, telefono: empresa.telefono }
    assert_redirected_to empresa_path(assigns(:empresa))
  end

  def test_destroy
    assert_difference("Empresa.count", -1) do
      delete :destroy, id: empresa
    end

    assert_redirected_to empresas_path
  end
end
