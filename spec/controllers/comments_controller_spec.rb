require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  
  describe 'POST create' do
    let(:place) { Fabricate(:place) }
     
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
end
