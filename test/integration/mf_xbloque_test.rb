require "test_helper"

class MfXbloque < Capybara::Rails::TestCase
  setup do
    #ApplicationController.any_instance.stubs(:current_user).returns(users(:fzerpa))
    Capybara.default_driver = :selenium
    login
  end

  test "mf x bloque c1" do

    visit 'censo_forestal/mf_bloque'
    #save_and_open_screenshot
    assert page.has_content?("Paisaje:")
    #click_button "Procesar"

  end

end
