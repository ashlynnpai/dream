require 'spec_helper'

describe Admin::PlacesController, type: :controller do
  describe 'DELETE destroy' do
    let(:user)  { Fabricate(:user) }
    let(:admin) { Fabricate(:admin) }
    let(:place) { Fabricate(:place, user_id: user.id) }
    before do
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(admin)
    end
    context 'as admin' do
      it 'destroys the place' do
        delete :destroy, { id: place.id }
        expect(Place.count).to eq(0)
      end
    end
  end
end
