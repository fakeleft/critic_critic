class UserOpinion < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  # delegate :like, movie_id:, :to => :user_opinion

end
