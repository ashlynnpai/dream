class CompletedBucketsController < ApplicationController
  
  def index
    @buckets = CompletedBuckets.for(current_user)
  end
end