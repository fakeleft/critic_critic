require 'test_helper'

class MoviesControllerTest < ActionController::TestCase
  setup do
    @movie = movies(:one)
    @movie.title = "The Internship"
    @movie.year = 2013
    @movie.description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla consequat, tortor et consequat laoreet, quam sapien porta metus, eu lacinia nisl lacus vel nibh. Duis a justo neque."
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movies)
  end

  test "should create movie" do
    assert_difference('Movie.count') do
      post :create, movie: { description: @movie.description, rt_id: @movie.rt_id, title: @movie.title, year: @movie.year }
    end

    assert_redirected_to movie_path(assigns(:movie))
  end

  test "should show movie" do
    get :show, id: @movie
    assert_response :success
  end
end