class Place < ActiveRecord::Base
	belongs_to :map
	has_many :photos
end
