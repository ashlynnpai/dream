require 'rails_helper'

RSpec.describe Comment, type: :model do
  
  it { should validate_presence_of(:message) }
  
  describe 'send_comment_email' do
    let(:user) { Fabricate(:user, notify_on_comment: true) }
    let(:place) { Fabricate(:place, user_id: user.id) }
    let(:commenter) { Fabricate(:user) }
    
    it 'sends an email' do
      comment = Fabricate(:comment, user_id: commenter.id, place_id: place.id)
      expect { comment.send_comment_email }
      .to change { ActionMailer::Base.deliveries.count }.by(1)
    end  
  end
end
