class ExpandDescriptionField < ActiveRecord::Migration
  def change
    change_column(:movies, :description, :text)
  end
end
