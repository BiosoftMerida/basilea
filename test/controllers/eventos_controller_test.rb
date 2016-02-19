require "test_helper"

class EventosControllerTest < ActionController::TestCase
  def evento
    @evento ||= eventos :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:eventos)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference("Evento.count") do
      post :create, evento: { cupos: evento.cupos, descripcion: evento.descripcion, email_contacto: evento.email_contacto, empresa_id: evento.empresa_id, fecha_fin: evento.fecha_fin, fecha_inicio: evento.fecha_inicio, horario: evento.horario, lugar: evento.lugar, mensaje_invitacion: evento.mensaje_invitacion, nombre: evento.nombre, precio: evento.precio, servicios: evento.servicios, tlf_contacto: evento.tlf_contacto }
    end

    assert_redirected_to evento_path(assigns(:evento))
  end

  def test_show
    get :show, id: evento
    assert_response :success
  end

  def test_edit
    get :edit, id: evento
    assert_response :success
  end

  def test_update
    put :update, id: evento, evento: { cupos: evento.cupos, descripcion: evento.descripcion, email_contacto: evento.email_contacto, empresa_id: evento.empresa_id, fecha_fin: evento.fecha_fin, fecha_inicio: evento.fecha_inicio, horario: evento.horario, lugar: evento.lugar, mensaje_invitacion: evento.mensaje_invitacion, nombre: evento.nombre, precio: evento.precio, servicios: evento.servicios, tlf_contacto: evento.tlf_contacto }
    assert_redirected_to evento_path(assigns(:evento))
  end

  def test_destroy
    assert_difference("Evento.count", -1) do
      delete :destroy, id: evento
    end

    assert_redirected_to eventos_path
  end
end
