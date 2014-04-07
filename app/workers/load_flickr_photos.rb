class LoadFlickrPhotos
  # include Sidekiq::Worker
  # include Sidetiq::Schedulable

  # recurrence { weekly(4) }

  FlickRaw.api_key = '06f65c8532aa60de4826737b5abd4101'
  FlickRaw.shared_secret = 'd9994a0cfe7020a8'

  PHOTO_ATTRIBUTES = ['photo_id','url','place_id','photo_timestamp']
  EXIF_KEYS = ['ExposureTime','FNumber','ExposureProgram','ISO','Flash','FocalLength','MeteringMode','FocalLength','ColorSpace','CreateDate'] 
  COORDS_URL = 'http://localhost:3000/coords'

  def perform 
  	place_coords = load_place_coords_feed

  	if place_coords.present?
  		Photo.destroy_all
	  	place_coords.each do |pc|
	  		place = Place.find(pc['id'])
	  		photos = flickr.photos.search(:lat => pc['latitude'], :lon => pc['longitude'])

	  		if photos.present? && place.present?
		  		photos.each do |p|
		  			 place.photos.create(photo_id: p.id)
		  		end
	  		end

	  	end
  	end
  end

  def load_place_coords_feed
		JSON.parse (Faraday.get COORDS_URL).body
  end

end