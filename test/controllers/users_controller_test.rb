require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @user.name = "Shane"
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { name: @user.name }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  # test "should show user" do
  #   get :show, id: @user
  #   assert_response :success
  # end

  test "should update user" do
    patch :update, id: @user, user: { name: @user.name }, movie_id: nil
    assert_redirected_to user_path(assigns(:user))
  end
end
