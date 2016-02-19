require "test_helper"

class EmpresaTest < ActiveSupport::TestCase
  def empresa
    @empresa ||= Empresa.new
  end

  def test_valid
    assert empresa.valid?
  end
end
