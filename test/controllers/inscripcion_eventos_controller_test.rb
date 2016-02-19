require "test_helper"

class InscripcionEventosControllerTest < ActionController::TestCase
  def inscripcion_evento
    @inscripcion_evento ||= inscripcion_eventos :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:inscripcion_eventos)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference("InscripcionEvento.count") do
      post :create, inscripcion_evento: { aceptado: inscripcion_evento.aceptado, contacto_id: inscripcion_evento.contacto_id, evento_id: inscripcion_evento.evento_id, fecha: inscripcion_evento.fecha, fecha_aceptado: inscripcion_evento.fecha_aceptado, fecha_pago: inscripcion_evento.fecha_pago, monto: inscripcion_evento.monto, nro_asiento: inscripcion_evento.nro_asiento, nro_pago: inscripcion_evento.nro_pago }
    end

    assert_redirected_to inscripcion_evento_path(assigns(:inscripcion_evento))
  end

  def test_show
    get :show, id: inscripcion_evento
    assert_response :success
  end

  def test_edit
    get :edit, id: inscripcion_evento
    assert_response :success
  end

  def test_update
    put :update, id: inscripcion_evento, inscripcion_evento: { aceptado: inscripcion_evento.aceptado, contacto_id: inscripcion_evento.contacto_id, evento_id: inscripcion_evento.evento_id, fecha: inscripcion_evento.fecha, fecha_aceptado: inscripcion_evento.fecha_aceptado, fecha_pago: inscripcion_evento.fecha_pago, monto: inscripcion_evento.monto, nro_asiento: inscripcion_evento.nro_asiento, nro_pago: inscripcion_evento.nro_pago }
    assert_redirected_to inscripcion_evento_path(assigns(:inscripcion_evento))
  end

  def test_destroy
    assert_difference("InscripcionEvento.count", -1) do
      delete :destroy, id: inscripcion_evento
    end

    assert_redirected_to inscripcion_eventos_path
  end
end
