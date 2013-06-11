class CreateUserOpinions < ActiveRecord::Migration
  def change
    create_table :user_opinions do |t|
      t.boolean :like
      t.integer :user_id
      t.integer :movie_id

      t.timestamps
    end
  end
end
