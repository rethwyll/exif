class AddTimeIntColumnToPhotos < ActiveRecord::Migration
  def change
  	add_column :photos, :time, :string
  end
end
