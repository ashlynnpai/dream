class CompletedBucketsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @buckets = CompletedBuckets.for(current_user)
  end
end