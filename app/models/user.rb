class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :movies, :through => :user_opinions
  has_many :user_opinions

  def top_critics(user_opinions)
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

end
