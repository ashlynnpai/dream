require 'rails_helper'

RSpec.describe CompletedBucketsController, type: :controller do
  describe 'GET index' do
    context "with authenticated user" do
      let(:place) { Fabricate(:place) }
      before do
        @user = Fabricate(:user)
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(@user)
      end  
      it 'does not include list_state todo' do
        place2 = Fabricate(:place)
        bucket1 = Bucket.create(place_id: place.id, user_id: @user.id, list_state: 'todo')
        bucket2 = Bucket.create(place_id: place2.id, user_id: @user.id, list_state: 'done')
        get :index
        expect(assigns(:buckets)).to eq([bucket2])
      end
    end
  end
  
  describe 'DELETE destroy' do
    context "with authenticated user" do
      let(:place) { Fabricate(:place) }
      before do
        @user = Fabricate(:user)
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(@user)
      end 
      it 'destroys the bucket' do
        bucket = Bucket.create(place_id: place.id, user_id: @user.id)
        delete :destroy, {id: bucket.id}
        expect(Bucket.count).to eq(0)
      end
    end
  end
end