class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
    	t.string :title
    	t.string :latitude
    	t.string :longitude
    	t.references :map

      t.timestamps
    end
  end
end
