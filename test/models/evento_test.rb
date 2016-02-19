require "test_helper"

class EventoTest < ActiveSupport::TestCase
  def evento
    @evento ||= Evento.new
  end

  def test_valid
    assert evento.valid?
  end
end
