class Place < ActiveRecord::Base
  include PgSearch
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :buckets
  
  geocoded_by :address
  after_validation :geocode
  
  validates :name, presence: true, length: { minimum: 3 }
  validates :address, presence: true
  validates :description, presence: true
  
  def rating
    comments.average(:rating) if comments.average(:rating)
  end
  
   pg_search_scope :kinda_spelled_like,
                  :against => [:name, :address],
                  :using => { :tsearch => { :prefix => true },
                  :trigram => { :only => :name }
                    }

end
