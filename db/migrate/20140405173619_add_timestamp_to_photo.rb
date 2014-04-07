class AddTimestampToPhoto < ActiveRecord::Migration
  def change
	add_column :photos, :photo_timestamp, :timestamp
  end
end
