class PhotosController < ApplicationController
  before_action :authenticate_user!, only: [:creat, :destroy]
  
  def create
    @place = Place.find(params[:place_id])
    @place.photos.create(photo_params.merge(user: current_user))
    redirect_to place_path(@place)
  end
  
  def show
    @photo = Photo.find(params[:id])
  end
  
  def destroy
    @photo = Photo.find(params[:id])
    return render text: 'Not Allowed', status: :forbidden unless @photo.user == current_user || current_user.admin?
    @photo.destroy
    redirect_to dashboard_path
  end
  
  private
  
  def photo_params
    params.require(:photo).permit(:caption, :image, :owner, :copyright)
  end
  
end

