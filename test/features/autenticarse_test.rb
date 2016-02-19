require "test_helper"

class CanAccessHomeTest < Capybara::Rails::TestCase
  setup do
    #ApplicationController.any_instance.stubs(:current_user).returns(users(:fzerpa))
    Capybara.default_driver = :selenium

    login
    assign_upa
  end

  test "usuario autenticado" do
    assert page.has_content?("Bienvenido")
  end

  test "upa asignada" do
    assert page.has_content?("Subcuena asignada con éxito")
  end
=begin
  test "cuota de explotacion c1" do

    visit 'censo_forestal/mf_cuota_explotacion'
    #save_and_open_screenshot
    assert page.has_content?("Paisaje:")
    click_button "Procesar"

  end
=end
end
