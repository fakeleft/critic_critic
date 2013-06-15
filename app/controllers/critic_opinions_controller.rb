class CriticOpinionsController < ApplicationController
  before_action :set_critic_opinion, only: [:show, :edit, :update, :destroy]

  # GET /critic_opinions
  # GET /critic_opinions.json
  def index
    @critic_opinions = CriticOpinion.all
  end

  # GET /critic_opinions/1
  # GET /critic_opinions/1.json
  def show

  end

  # GET /critic_opinions/new
  def new
    @critic_opinion = CriticOpinion.new
  end

  # GET /critic_opinions/1/edit
  def edit
  end

  # POST /critic_opinions
  # POST /critic_opinions.json
  def create
    @critic_opinion = CriticOpinion.new(critic_opinion_params)

    respond_to do |format|
      if @critic_opinion.save
        format.html { redirect_to @critic_opinion, notice: 'Critic opinion was successfully created.' }
        format.json { render action: 'show', status: :created, location: @critic_opinion }
      else
        format.html { render action: 'new' }
        format.json { render json: @critic_opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /critic_opinions/1
  # PATCH/PUT /critic_opinions/1.json
  def update
    respond_to do |format|
      if @critic_opinion.update(critic_opinion_params)
        format.html { redirect_to @critic_opinion, notice: 'Critic opinion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @critic_opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /critic_opinions/1
  # DELETE /critic_opinions/1.json
  def destroy
    @critic_opinion.destroy
    respond_to do |format|
      format.html { redirect_to critic_opinions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_critic_opinion
      @critic_opinion = CriticOpinion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def critic_opinion_params
      params.require(:critic_opinion).permit(:like, :user_id, :critic_id)
    end
end
