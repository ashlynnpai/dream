class CompletedBuckets
  def self.for(user)
    user.buckets.where(list_state: "done")
  end
end
  
  
