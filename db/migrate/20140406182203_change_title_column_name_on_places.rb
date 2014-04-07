class ChangeTitleColumnNameOnPlaces < ActiveRecord::Migration
  def change
  	remove_column :places, :title
  	add_column :places, :site, :string
  end
end
