class Movie < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :year, presence: true, numericality: true

  has_many :critic_opinions
  has_many :critics, :through => :critic_opinions
  has_many :users, :through => :user_opinions
end
