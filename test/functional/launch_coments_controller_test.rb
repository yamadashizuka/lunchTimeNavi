require 'test_helper'

class LaunchComentsControllerTest < ActionController::TestCase
  setup do
    @launch_coment = launch_coments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:launch_coments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create launch_coment" do
    assert_difference('LaunchComent.count') do
      post :create, launch_coment: { launch_coment_text: @launch_coment.launch_coment_text, name: @launch_coment.name }
    end

    assert_redirected_to launch_coment_path(assigns(:launch_coment))
  end

  test "should show launch_coment" do
    get :show, id: @launch_coment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @launch_coment
    assert_response :success
  end

  test "should update launch_coment" do
    put :update, id: @launch_coment, launch_coment: { launch_coment_text: @launch_coment.launch_coment_text, name: @launch_coment.name }
    assert_redirected_to launch_coment_path(assigns(:launch_coment))
  end

  test "should destroy launch_coment" do
    assert_difference('LaunchComent.count', -1) do
      delete :destroy, id: @launch_coment
    end

    assert_redirected_to launch_coments_path
  end
end
