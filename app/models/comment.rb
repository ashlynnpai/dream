class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :place
  after_create :send_comment_email
  
  validates :message, presence: true
  
  def send_comment_email
    #if user.notify_on_comment == true
      NotificationMailer.comment_added(self).deliver
    #end
  end
end
