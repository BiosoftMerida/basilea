require "test_helper"

class ContactoTest < ActiveSupport::TestCase
  def contacto
    @contacto ||= Contacto.new
  end

  def test_valid
    assert contacto.valid?
  end
end
