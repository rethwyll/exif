class AddPlaceIdToExifAttribute < ActiveRecord::Migration
  def change
    add_column :exif_attributes, :place_id, :integer
  end
end
