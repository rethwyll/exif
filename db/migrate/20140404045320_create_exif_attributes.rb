class CreateExifAttributes < ActiveRecord::Migration
  def change
    create_table :exif_attributes do |t|
    	t.string :title
    	t.string :value
    	t.references :photo

      t.timestamps
    end
  end
end
