class AddMovieIdsToCriticOpinion < ActiveRecord::Migration
  def change
    add_column :critic_opinions, :movie_id, :integer
  end
end
