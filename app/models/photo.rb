class Photo < ActiveRecord::Base
	belongs_to :place 
	has_many :exif_attributes
end
