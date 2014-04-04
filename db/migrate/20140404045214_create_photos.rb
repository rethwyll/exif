class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
    	t.string :photo_id
    	t.string :url
    	t.references :place

      t.timestamps
    end
  end
end
