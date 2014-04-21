class AddValueLabelToExifAttributes < ActiveRecord::Migration
  def change
  	add_column :exif_attributes, :value_label, :string
  end
end
