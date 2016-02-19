require "test_helper"

class MinisterioTest < ActiveSupport::TestCase
  def ministerio
    @ministerio ||= Ministerio.new
  end

  def test_valid
    assert ministerio.valid?
  end
end
