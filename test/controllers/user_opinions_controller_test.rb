require 'test_helper'

class UserOpinionsControllerTest < ActionController::TestCase
  setup do
    @user_opinion = user_opinions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_opinions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_opinion" do
    assert_difference('UserOpinion.count') do
      post :create, user_opinion: { like: @user_opinion.like, movie_id: @user_opinion.movie_id, user_id: @user_opinion.user_id }
    end

    assert_redirected_to user_opinion_path(assigns(:user_opinion))
  end

  test "should show user_opinion" do
    get :show, id: @user_opinion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_opinion
    assert_response :success
  end

  test "should update user_opinion" do
    patch :update, id: @user_opinion, user_opinion: { like: @user_opinion.like, movie_id: @user_opinion.movie_id, user_id: @user_opinion.user_id }
    assert_redirected_to user_opinion_path(assigns(:user_opinion))
  end

  test "should destroy user_opinion" do
    assert_difference('UserOpinion.count', -1) do
      delete :destroy, id: @user_opinion
    end

    assert_redirected_to user_opinions_path
  end
end
