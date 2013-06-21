class ChangeMovieReleasedateToStringObj < ActiveRecord::Migration
  def up
    remove_column :movies, :release_date
    add_column :movies, :release_date, :string
  end

  def down
    remove_column :movies, :release_date
    add_column :movies, :release_date, :datetime
  end
end
