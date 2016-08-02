class Place < ActiveRecord::Base
  include PgSearch
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :buckets, dependent: :destroy
  has_many :place_categories
  has_many :categories, through: :place_categories
  
  geocoded_by :address
  after_validation :geocode
  
  validates :name, presence: true, length: { minimum: 3 }
  validates :address, presence: true
  
  def geocode
    if latitude.blank? && longitude.blank?
      super
    end
  end
  
  def avg_rating
    comments.average(:rating) if comments.average(:rating)
  end
  
   pg_search_scope :kinda_spelled_like,
                  :against => [:name, :address],
                  :using => { :tsearch => { :prefix => true },
                  :trigram => { :only => :name }
                    }

end
