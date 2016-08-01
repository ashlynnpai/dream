class CompletedBucketsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @completed_buckets = CompletedBuckets.for(current_user)
  end
  
  def destroy
    @bucket = Bucket.find(params[:id])
    @bucket.destroy
    redirect_to completed_buckets_path
  end
end