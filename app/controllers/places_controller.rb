class PlacesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update]
  
  def index
    @places = Place.paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html
      format.json{render json: @places}
      format.xml{render xml: @places}
    end
  end
  
  def create
    @place = current_user.places.create(place_params)
    if @place.valid?
      redirect_to place_path(@place)
    else
      render :search, status: :unprocessable_entity
    end
  end
  
  def show
    @place = Place.find(params[:id])
    @comment = Comment.new
    @photo = Photo.new
  end
  
  def edit
    @place = Place.find(params[:id])
    
    return render text: 'Not Allowed', status: :forbidden unless @place.user == current_user || current_user.admin?
  end
  
  def update
    @place = Place.find(params[:id])
    return render text: 'Not Allowed', status: :forbidden unless @place.user == current_user || current_user.admin?
    @place.update_attributes(place_params)
    if @place.valid?
      redirect_to place_path(@place)
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def search
    @results = Place.kinda_spelled_like(params[:q])
    @place = Place.new
  end
  
  private
  
  def place_params
    if current_user.admin? || @place.nil?
      params.require(:place).permit(:name, :address, :description)
    else
      params.require(:place).permit(:description)
    end
  end
end
