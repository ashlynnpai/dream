require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  
  describe 'POST create' do
    let(:place_creator) { Fabricate(:user) }
    let(:place) { Fabricate(:place, user: place_creator) }
     
    context 'with authenticated users' do
      let(:user) { Fabricate(:user) }
      before do
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(user)
      end
      
      it 'creates a review' do
        post :create, comment: Fabricate.attributes_for(:comment), place_id: place.id
        expect(Comment.count).to eq(1)
      end
      
      it 'redirects to the place path' do
        post :create, comment: Fabricate.attributes_for(:comment), place_id: place.id
        expect(response).to redirect_to place_path(place)        
      end
    end
  end
  
  describe 'PUT update' do
    let(:place_creator) { Fabricate(:user) }
    let(:place) { Fabricate(:place, user: place_creator) }
    
    context "with the user's own review" do
      let(:user) { Fabricate(:user) }
      before do
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(user)
      end
    
      it 'updates the review' do
        comment = Fabricate(:comment, place_id: place.id, user_id: user.id, message: 'old')
        put :update, id: comment.id, place_id: place.id, user_id: user.id, comment: { message: 'new' }
        expect(comment.reload.message).to eq('new')    
      end
    end
    
    context "not with the user's own review" do
      let(:user) { Fabricate(:user) }
      before do
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(user)
      end
    
      it 'does not update the review' do
        creator = Fabricate(:user)
        comment = Fabricate(:comment, place_id: place.id, user_id: creator.id, message: 'old')
        put :update, id: comment.id, place_id: place.id, user_id: creator.id, comment: { message: 'new' }
        expect(comment.reload.message).to eq('old')    
      end
    end
  end
end



  
  
  
