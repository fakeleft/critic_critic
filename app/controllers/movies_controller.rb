class MoviesController < ApplicationController
  before_action :set_movie, only: [:show]

  # GET /movies
  # GET /movies.json
  def index
    unless params['search'].nil?
      @movies = Movie.find(:all, :conditions => ["title ~* '.*#{params['search']}*.'"])
    else
      @movies = Movie.all
    end
  end
  # GET /movies/1
  # GET /movies/1.json
  def show
    @opinions = CriticOpinion.where({ :movie_id => @movie.id })
  end

  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @movie }
      else
        format.html { render action: 'new' }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:rt_id, :description, :year, :title)
    end
end
