require 'test_helper'

class LtiUserSessionsControllerTest < ActionController::TestCase
  setup do
    @lti_user_session = lti_user_sessions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lti_user_sessions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lti_user_session" do
    assert_difference('LtiUserSession.count') do
      post :create, lti_user_session: { userEmail: @lti_user_session.userEmail, userId: @lti_user_session.userId, username: @lti_user_session.username }
    end

    assert_redirected_to lti_user_session_path(assigns(:lti_user_session))
  end

  test "should show lti_user_session" do
    get :show, id: @lti_user_session
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lti_user_session
    assert_response :success
  end

  test "should update lti_user_session" do
    put :update, id: @lti_user_session, lti_user_session: { userEmail: @lti_user_session.userEmail, userId: @lti_user_session.userId, username: @lti_user_session.username }
    assert_redirected_to lti_user_session_path(assigns(:lti_user_session))
  end

  test "should destroy lti_user_session" do
    assert_difference('LtiUserSession.count', -1) do
      delete :destroy, id: @lti_user_session
    end

    assert_redirected_to lti_user_sessions_path
  end
end
