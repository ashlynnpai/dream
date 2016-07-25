class NotificationMailer < ApplicationMailer
  default from: "no-reply@dreamplaces.herokuapp.com"
  
  def comment_added
    mail(to: "user@example.com",
         subject: "A comment has been added to your place")
  end

end
