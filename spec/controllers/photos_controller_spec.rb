require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  
  describe 'POST create' do
    let(:place) { Fabricate(:place) }
    let(:user) { Fabricate(:user) }
     
    context 'with authenticated users' do
      before do
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(user)
      end

      it 'creates a photo' do
        post :create, photo: Fabricate.attributes_for(:photo), place_id: place.id
        expect(Photo.count).to eq(1)
      end

      it 'redirects to the place path' do
        post :create, photo: Fabricate.attributes_for(:photo), place_id: place.id
        expect(response).to redirect_to place_path(place)        
      end
      
      it 'associates the user with the photo' do
        post :create, photo: Fabricate.attributes_for(:photo), place_id: place.id
        expect(Photo.first.user).to eq(user)
      end
      
      it 'associates the place with the photo' do
        post :create, photo: Fabricate.attributes_for(:photo), place_id: place.id
        expect(Photo.first.place).to eq(place)
      end
    end
    
    context 'with authenticated users' do
      it 'does not create a photo' do
        post :create, photo: Fabricate.attributes_for(:photo), place_id: place.id
        expect(Photo.count).to eq(0)
      end  
      
      it 'redirects to the new_user_session path' do
        post :create, photo: Fabricate.attributes_for(:photo), place_id: place.id
        expect(response).to redirect_to new_user_session_path        
      end
    end
  end
end