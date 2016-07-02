class PlacesController < ApplicationController
  
  def index
    @places = Place.paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html
      format.json{render json: @places}
      format.xml{render xml: @places}
    end
  end
  
  def new
    @place = Place.new
  end
end
