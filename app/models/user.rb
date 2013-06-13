class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :movies, :through => :user_opinions
end
