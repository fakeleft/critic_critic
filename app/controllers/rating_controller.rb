class RatingController < ApplicationController

  def index
    @user = User.first
    @movies = Movie.all
  end

end
