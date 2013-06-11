class CreateCriticOpinions < ActiveRecord::Migration
  def change
    create_table :critic_opinions do |t|
      t.boolean :like
      t.integer :user_id
      t.integer :critic_id

      t.timestamps
    end
  end
end
