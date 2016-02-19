require "test_helper"

class InscripcionEventoTest < ActiveSupport::TestCase
  def inscripcion_evento
    @inscripcion_evento ||= InscripcionEvento.new
  end

  def test_valid
    assert inscripcion_evento.valid?
  end
end
