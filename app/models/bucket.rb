class Bucket < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :place
  
end
