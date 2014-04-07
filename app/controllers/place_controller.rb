class PlaceController < ApplicationController
	respond_to :json

  def index
		respond_with Place.all
  end
end
