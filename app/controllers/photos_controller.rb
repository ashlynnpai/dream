class PhotosController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  
  def create
    @place = Place.find(params[:place_id])
    @photo = @place.photos.build(photo_params)   
    if @photo.save
      flash[:notice] = "Your photo was uploaded."
      redirect_to place_path(@place)
    else
      @photos = @place.photos.reload
      redirect_to :back, alert: "Your photo was not uploaded"
    end
  end
  
  def show
    @photo = Photo.find(params[:id])
  end
  
  def destroy
    @photo = Photo.find(params[:id])
    @place = @photo.place
    return render text: 'Not Allowed', status: :forbidden unless @photo.user == current_user || current_user.admin?
    @photo.destroy
    redirect_to place_path(@place)
  end
  
  private
  
  def photo_params
    params.require(:photo).permit(:caption, :image, :owner, :copyright).merge(user: current_user)
  end
  
end

