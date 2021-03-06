class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  obfuscate_id :spin => 7538204
  
  validates :username, presence: true,  uniqueness: { case_sensitive: false }
  
  has_many :places
  has_many :comments
  has_many :photos
  has_many :buckets
  
end
