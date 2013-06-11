require 'test_helper'

class CriticOpinionsControllerTest < ActionController::TestCase
  setup do
    @critic_opinion = critic_opinions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:critic_opinions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create critic_opinion" do
    assert_difference('CriticOpinion.count') do
      post :create, critic_opinion: { critic_id: @critic_opinion.critic_id, like: @critic_opinion.like, user_id: @critic_opinion.user_id }
    end

    assert_redirected_to critic_opinion_path(assigns(:critic_opinion))
  end

  test "should show critic_opinion" do
    get :show, id: @critic_opinion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @critic_opinion
    assert_response :success
  end

  test "should update critic_opinion" do
    patch :update, id: @critic_opinion, critic_opinion: { critic_id: @critic_opinion.critic_id, like: @critic_opinion.like, user_id: @critic_opinion.user_id }
    assert_redirected_to critic_opinion_path(assigns(:critic_opinion))
  end

  test "should destroy critic_opinion" do
    assert_difference('CriticOpinion.count', -1) do
      delete :destroy, id: @critic_opinion
    end

    assert_redirected_to critic_opinions_path
  end
end
