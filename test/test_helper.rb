ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/rails/capybara"
require "mocha/mini_test"
require 'capybara-screenshot/minitest'
require 'selenium-webdriver'

class ActionController::TestCase
  include Devise::TestHelpers
end

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  fixtures :all

  def login
    @user = users(:fzerpa)
    visit root_path
    fill_in 'Usuario', with: @user.username
    fill_in 'Contraseña', with: '12345678'
    click_button 'Entrar'
  end


  def assign_upa
    visit settings_path
    Capybara.default_max_wait_time = 5
    select('Cuenca Santa Maria', :from => 'settings_cuenca')
    select('Subcuenca Santa Maria I', :from => 'settings_subcuenca')

    click_button 'Guardar'
  end

end



class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include Capybara::Assertions
  include Capybara::Screenshot::MiniTestPlugin
end
