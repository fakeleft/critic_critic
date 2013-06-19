class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :movies, :through => :user_opinions
  has_many :user_opinions

  def top_critics
    Critic.take(5).shuffle
  end
end
