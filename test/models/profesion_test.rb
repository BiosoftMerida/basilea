require "test_helper"

class ProfesionTest < ActiveSupport::TestCase
  def profesion
    @profesion ||= Profesion.new
  end

  def test_valid
    assert profesion.valid?
  end
end
