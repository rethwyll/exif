class LoadFlickrPhotos
  # include Sidekiq::Worker
  # include Sidetiq::Schedulable

  # recurrence { weekly(4) }

  FlickRaw.api_key = '06f65c8532aa60de4826737b5abd4101'
  FlickRaw.shared_secret = 'd9994a0cfe7020a8'

  EXIF_KEYS = ['ExposureTime','FNumber','ExposureProgram','ISO','Flash','FocalLength','MeteringMode','ColorSpace'] 

  def perform 
  	places = Place.all

  	if places.present?
  		Photo.destroy_all
	  	places.each do |place|
	  		begin
		  		photos = flickr.photos.search(:page => 5, :lat => place.latitude, :lon => place.longitude, :extras => 'date_taken, url_sq, url_t, url_s, url_q, url_m, url_n, url_z, url_c, url_l, url_o')
		  		photos.each do |photo|
		  			photo = place.photos.create( photo_id: photo.id, url: '', photo_timestamp: photo.datetaken, time: /(\d{2}):/.match(photo.datetaken)[0].to_i )
		  		end
	  		rescue
	  		end
	  	end
  	end
  end

end