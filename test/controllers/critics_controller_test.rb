require 'test_helper'

class CriticsControllerTest < ActionController::TestCase
  setup do
    @critic = critics(:one)
    @critic.name = "Jordan"
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:critics)
  end

  test "should show critic" do
    get :show, id: @critic
    assert_response :success
  end
end
