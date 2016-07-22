class PlacesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  
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
      redirect_to root_path
    else
      render :search, status: :unprocessable_entity
    end
  end
  
  def show
    @place = Place.find(params[:id])
    @comment = Comment.new
    @photo = Photo.new(place: @place, user: current_user)
  end
  
  def edit
    @place = Place.find(params[:id])  
    return render text: 'Not Allowed', status: :forbidden unless @place.user == current_user || current_user.admin?
  end
  
  def update
    @place = Place.find(params[:id])
    @place.update_attributes(place_params)
    if @place.valid?
      redirect_to place_path(@place)
    else
      @photo = @place.photos.last
      @comment = Comment.new
      render :show, status: :unprocessable_entity
    end
  end
  
  def search
    @results = Place.kinda_spelled_like(params[:q])
    @place = Place.new
  end
  
  private
  
  def place_params
    if current_user.admin? || @place.nil?
      params.require(:place).permit(:name, :address, :description, photos_attributes: [:image, :owner, :caption, :copyright])
    elsif @place.user == current_user
      params.require(:place).permit(:description, photos_attributes: [:image, :owner, :caption, :copyright])
    elsif current_user
      params.require(:place).permit(photos_attributes: [:image, :owner, :caption, :copyright])
    end
  end
end
