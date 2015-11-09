require 'test_helper'

class AjaxControllerTest < ActionController::TestCase
  test "should get users" do
    get :users
    assert_response :success
  end

end
