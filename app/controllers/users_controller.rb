class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]

  def index
    @user = User.first
    redirect_to @user
  end

  # GET /users/1
  # GET /users/1.json
  def show
     @user_opinions = session[:user_opinions]
     @user_opinions = @user_opinions.map { | movie_id, like | { Movie.find_by_id(movie_id) => like } }
     @user_opinions.reject! {| key, value | key.nil? }
     top_critics
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update

    unless params["user"]["movie_id"].nil?
      if session.has_key? :user_opinions
        session[:user_opinions] = session[:user_opinions].merge params["user"]["movie_id"]
      else
        session[:user_opinions] = params["user"]["movie_id"]
      end
    end
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: '' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def top_critics
    user_opinions = session[:user_opinions]
    score = Hash.new
    CriticOpinion.all.each do |opinion|
      movie_id = opinion.movie_id.to_s
      like = opinion.like.to_s
      if user_opinions.has_key? movie_id
        score[opinion.critic_id] ||= {agree: 0, disagree: 0}
        if user_opinions[movie_id] == like
          score[opinion.critic_id][:agree] += 1
        else
          score[opinion.critic_id][:disagree] += 1
        end
      end
    end
     rank = rank_critic(score).take(5)
     @top_critics = rank.map { |critic_id, hash| {Critic.find_by_id(critic_id) => hash} }
  end

  def rank_critic(score)
    score.sort_by do |critic, hash|
      hash[:disagree] - hash[:agree]
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :id, :movie_id)
    end
end
