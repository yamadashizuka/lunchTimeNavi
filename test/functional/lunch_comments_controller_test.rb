require 'test_helper'

class LunchCommentsControllerTest < ActionController::TestCase
  setup do
    @lunch_comment = lunch_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lunch_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lunch_comment" do
    assert_difference('LunchComment.count') do
      post :create, lunch_comment: { name: @lunch_comment.name, text: @lunch_comment.text }
    end

    assert_redirected_to lunch_comment_path(assigns(:lunch_comment))
  end

  test "should show lunch_comment" do
    get :show, id: @lunch_comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lunch_comment
    assert_response :success
  end

  test "should update lunch_comment" do
    put :update, id: @lunch_comment, lunch_comment: { name: @lunch_comment.name, text: @lunch_comment.text }
    assert_redirected_to lunch_comment_path(assigns(:lunch_comment))
  end

  test "should destroy lunch_comment" do
    assert_difference('LunchComment.count', -1) do
      delete :destroy, id: @lunch_comment
    end

    assert_redirected_to lunch_comments_path
  end
end
