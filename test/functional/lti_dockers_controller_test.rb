require 'test_helper'

class LtiDockersControllerTest < ActionController::TestCase
  setup do
    @lti_docker = lti_dockers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lti_dockers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lti_docker" do
    assert_difference('LtiDocker.count') do
      post :create, lti_docker: { appdesc: @lti_docker.appdesc, appname: @lti_docker.appname, expired: @lti_docker.expired, host: @lti_docker.host, port: @lti_docker.port, pw: @lti_docker.pw, string: @lti_docker.string, string: @lti_docker.string, userEmail: @lti_docker.userEmail, userId: @lti_docker.userId, username: @lti_docker.username }
    end

    assert_redirected_to lti_docker_path(assigns(:lti_docker))
  end

  test "should show lti_docker" do
    get :show, id: @lti_docker
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lti_docker
    assert_response :success
  end

  test "should update lti_docker" do
    put :update, id: @lti_docker, lti_docker: { appdesc: @lti_docker.appdesc, appname: @lti_docker.appname, expired: @lti_docker.expired, host: @lti_docker.host, port: @lti_docker.port, pw: @lti_docker.pw, string: @lti_docker.string, string: @lti_docker.string, userEmail: @lti_docker.userEmail, userId: @lti_docker.userId, username: @lti_docker.username }
    assert_redirected_to lti_docker_path(assigns(:lti_docker))
  end

  test "should destroy lti_docker" do
    assert_difference('LtiDocker.count', -1) do
      delete :destroy, id: @lti_docker
    end

    assert_redirected_to lti_dockers_path
  end
end
