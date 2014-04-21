class ExifAttribute < ActiveRecord::Base
	belongs_to :photo
	belongs_to :place
end
