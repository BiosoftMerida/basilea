require "test_helper"

class ContactosControllerTest < ActionController::TestCase
  def contacto
    @contacto ||= contactos :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:contactos)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference("Contacto.count") do
      post :create, contacto: { apellidos: contacto.apellidos, doc_identidad: contacto.doc_identidad, email: contacto.email, empresa_id: contacto.empresa_id, estado_id: contacto.estado_id, iglesia: contacto.iglesia, ministerio_id: contacto.ministerio_id, nombres: contacto.nombres, profesion_id: contacto.profesion_id, telefono: contacto.telefono }
    end

    assert_redirected_to contacto_path(assigns(:contacto))
  end

  def test_show
    get :show, id: contacto
    assert_response :success
  end

  def test_edit
    get :edit, id: contacto
    assert_response :success
  end

  def test_update
    put :update, id: contacto, contacto: { apellidos: contacto.apellidos, doc_identidad: contacto.doc_identidad, email: contacto.email, empresa_id: contacto.empresa_id, estado_id: contacto.estado_id, iglesia: contacto.iglesia, ministerio_id: contacto.ministerio_id, nombres: contacto.nombres, profesion_id: contacto.profesion_id, telefono: contacto.telefono }
    assert_redirected_to contacto_path(assigns(:contacto))
  end

  def test_destroy
    assert_difference("Contacto.count", -1) do
      delete :destroy, id: contacto
    end

    assert_redirected_to contactos_path
  end
end
