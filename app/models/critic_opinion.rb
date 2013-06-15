class CriticOpinion < ActiveRecord::Base
  belongs_to :critic
  belongs_to :movie

  delegate :publication, :name, :to => :critic
  delegate :title, :to => :movie

end
