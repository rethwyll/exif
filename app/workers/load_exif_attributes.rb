class LoadExifAttributes
  # include Sidekiq::Worker
  # include Sidetiq::Schedulable

  # recurrence { weekly(4) }

  FlickRaw.api_key = '06f65c8532aa60de4826737b5abd4101'
  FlickRaw.shared_secret = 'd9994a0cfe7020a8'

  EXIF_KEYS = ['ExposureTime','FNumber','ISO','Flash','FocalLength','MeteringMode','ColorSpace','ExposureProgram'] 

  def perform 
  	photos = Photo.all

  	if photos.present?
  		ExifAttribute.destroy_all
	  	photos.each do |photo|
	  		begin
	  			exifAttributes = flickr.photos.getExif( photo_id: photo.id ).exif.collect!{|e| e if EXIF_KEYS.include? e.tag }.compact
	  			exifAttributes.each do |e|
	  				photo.exif_attributes.create( tag: e.tag, title: e.label, value: e.raw, value_label: e.clean, place_id: photo.place_id )
	  			end
	  		rescue
	  		end
	  	end
  	end
  end

end