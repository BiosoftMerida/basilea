require 'test_helper'

class EditProfileTest < ActionDispatch::IntegrationTest
  def setup
    login
  end

=begin
  def teardown
    logout
  end
=end
  test 'edit a user account details' do
    #@fzerpa = users(:fzerpa)
    #visit users_edit_path(@fzerpa, as: @user.id)

    @user = users(:fzerpa)
    visit users/edit_user/:@user.id



    fill_in 'Nombre:', with: 'Francisco Parra'
    click_button 'Guardar'

    @fzerpa.reload

    assert_equal 'francisco parra', @fzerpa.name.downcase
  end
end