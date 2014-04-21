class AddTagToExifAttribute < ActiveRecord::Migration
  def change
    add_column :exif_attributes, :tag, :string
  end
end
