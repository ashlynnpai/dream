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
  
  def create
    @place = Place.create(place_params)
    redirect_to root_path
  end
  
  private
  
  def place_params
    params.require(:place).permit(:name, :address, :description)
  end
end
