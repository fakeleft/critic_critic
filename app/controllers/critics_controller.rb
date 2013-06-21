class CriticsController < ApplicationController
  before_action :set_critic, only: [:show]

  # GET /critics
  # GET /critics.json
  def index
    @critics = Critic.all
  end

  # GET /critics/1
  # GET /critics/1.json
  def show
    @opinions = CriticOpinion.where({ :critic_id => @critic.id })
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_critic
      @critic = Critic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def critic_params
      params.require(:critic).permit(:name, :url, :publication)
    end
end
