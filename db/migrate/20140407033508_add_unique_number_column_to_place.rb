class AddUniqueNumberColumnToPlace < ActiveRecord::Migration
  def change
  	add_column :places, :unique_number, :string
  end
end
