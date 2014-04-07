class AddColumnsToPlace < ActiveRecord::Migration
  def change
  	add_column :places, :short_description, :string
  	add_column :places, :image_url, :string
  	add_column :places, :states, :string
  end
end
