class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.string :description
      t.integer :rt_id
      t.timestamps
    end
  end
end
