require 'test_helper'

class UserAuthenticationTest < Capybara::Rails::TestCase
  def setup
    login
  end


  test 'visit home page and login' do
    assert page.has_content?("Bienvenido")
  end

end