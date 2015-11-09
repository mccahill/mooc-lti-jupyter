require 'test_helper'

class AdministrationControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
