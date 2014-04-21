class PlaceController < ApplicationController
	respond_to :json

  def index
		respond_with Place.all
  end

  def coords
  	respond_with Place.all.collect {|p| { latitude: p.latitude, longitude: p.longitude, id: p.id }}
  end 

end
