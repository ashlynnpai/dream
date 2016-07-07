class Bucket < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :place
  
  scope :todo, -> { where(list_state: "todo") }
  scope :done, -> { where(list_state: "done") }
end
