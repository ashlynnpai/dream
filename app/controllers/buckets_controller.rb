class BucketsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @buckets = current_user.buckets.todo
  end
  
  def create
    @place = Place.find(params[:place_id])
    Bucket.create(place: @place, user: current_user, position: last_position, list_state: "todo") unless current_user.buckets.map(&:place).include?(@place)
    redirect_to bucketlist_path
  end
  
  def update
    @bucket = Bucket.find(params[:id])
    @bucket.update_attributes(bucket_params)
    if @bucket.valid?
      redirect_to bucketlist_path
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  private
  
  def last_position
    current_user.buckets.count + 1
  end
  
  def bucket_params
    params.require(:bucket).permit(:position, :list_state)
  end
end