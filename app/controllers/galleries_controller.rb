class GalleriesController < ApplicationController
  
  def index
    @place = Place.find(params[:place_id])
  end
  
end