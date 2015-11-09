require 'test_helper'

class LtiNoncesControllerTest < ActionController::TestCase
  setup do
    @lti_nonce = lti_nonces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lti_nonces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lti_nonce" do
    assert_difference('LtiNonce.count') do
      post :create, lti_nonce: { nonce: @lti_nonce.nonce, userId: @lti_nonce.userId }
    end

    assert_redirected_to lti_nonce_path(assigns(:lti_nonce))
  end

  test "should show lti_nonce" do
    get :show, id: @lti_nonce
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lti_nonce
    assert_response :success
  end

  test "should update lti_nonce" do
    put :update, id: @lti_nonce, lti_nonce: { nonce: @lti_nonce.nonce, userId: @lti_nonce.userId }
    assert_redirected_to lti_nonce_path(assigns(:lti_nonce))
  end

  test "should destroy lti_nonce" do
    assert_difference('LtiNonce.count', -1) do
      delete :destroy, id: @lti_nonce
    end

    assert_redirected_to lti_nonces_path
  end
end
