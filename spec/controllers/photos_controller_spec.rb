require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  
  describe 'POST create' do
    let(:place) { Fabricate(:place) }
     
    context 'with authenticated users' do
      before do
        @user = Fabricate(:user)
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(@user)
      end

      it 'creates a review' do
        post :create, photo: Fabricate.attributes_for(:photo), place_id: place.id
        expect(Photo.count).to eq(1)
      end

      it 'redirects to the place path' do
        post :create, photo: Fabricate.attributes_for(:photo), place_id: place.id
        expect(response).to redirect_to place_path(place)        
      end
    end
  end
end