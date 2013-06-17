class UserOpinionsController < ApplicationController
  before_action :set_user_opinion, only: [:show, :edit, :update, :destroy]


  # GET /user_opinions
  # GET /user_opinions.json
  def index
    @user_opinions = UserOpinion.all

    @movies = Movie.all
  end

  # GET /user_opinions/1
  # GET /user_opinions/1.json
  def show
  end

  # GET /user_opinions/new
  def new
    @user_opinion = UserOpinion.new
  end

  # GET /user_opinions/1/edit
  def edit
  end

  # POST /user_opinions
  # POST /user_opinions.json
  def create
    @user_opinion = UserOpinion.new(user_opinion_params)

    respond_to do |format|
      if @user_opinion.save
        format.html { redirect_to @user_opinion, notice: 'User opinion was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_opinion }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_opinions/1
  # PATCH/PUT /user_opinions/1.json
  def update
    respond_to do |format|
      if @user_opinion.update(user_opinion_params)
        format.html { redirect_to @user_opinion, notice: 'User opinion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_opinions/1
  # DELETE /user_opinions/1.json
  def destroy
    @user_opinion.destroy
    respond_to do |format|
      format.html { redirect_to user_opinions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_opinion
      @user_opinion = UserOpinion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_opinion_params
      params.require(:user_opinion).permit(:like, :user_id, :movie_id)
    end
end
