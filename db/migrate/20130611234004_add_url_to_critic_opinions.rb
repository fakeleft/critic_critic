class AddUrlToCriticOpinions < ActiveRecord::Migration
  def change
    add_column :critic_opinions, :url, :string
  end
end
