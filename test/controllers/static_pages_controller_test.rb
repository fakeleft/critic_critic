require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get movies" do
    get :movies
    assert_response :success
  end

end
