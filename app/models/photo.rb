class Photo < ActiveRecord::Base
  
  belongs_to :place
  belongs_to :user
  
  mount_uploader :image, ImageUploader
  
  validates :image, 
                    file_size: { less_than: 10.megabytes,
                                  message: 'file size must be less than 10 MB'},
                    file_content_type: { allow: ['image/jpeg', 'image/jpg', 'image/png'],
                                  message: 'only jpeg and gif files can be uploaded'}
  
  validates_presence_of :image

  
end
