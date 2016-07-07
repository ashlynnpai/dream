class BucketsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @buckets = current_user.buckets.todo
  end
  
  def create
    @place = Place.find(params[:place_id])
    Bucket.create(place: @place, user: current_user, position: last_position) unless current_user.buckets.map(&:place).include?(@place)
    redirect_to buckets_path
  end
  
  def visited
    @buckets_done = current_user.buckets.done
  end
  
  private
  
  def last_position
    current_user.buckets.count + 1
  end
end