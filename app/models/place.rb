class Place < ActiveRecord::Base
	belongs_to :map
	has_many :photos
	has_many :exif_attributes
end
