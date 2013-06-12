class Critic < ActiveRecord::Base
  validates :name, presence: true

  has_many :critic_opinions
  has_many :movies, :through => :critic_opinions
end
