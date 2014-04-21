class ExifAttributeController < ApplicationController
	respond_to :json

  def index
		respond_with ExifAttribute.all
  end  

  def fnumber
		respond_with ExifAttribute.where("place_id" => params[:place_id], "tag" => "FNumber")
  end

  def exposuretime
    respond_with ExifAttribute.where("place_id" => params[:place_id], "tag" => "ExposureTime")
  end 

end
