require 'rails_helper'

RSpec.describe BucketsController, type: :controller do
  describe 'GET index' do
    context "with authenticated user" do
      let(:place) { Fabricate(:place) }
      before do
        @user = Fabricate(:user)
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(@user)
      end  
      it 'does not include list_state done' do
        place2 = Fabricate(:place)
        bucket1 = Bucket.create(place_id: place.id, user_id: @user.id, list_state: 'todo')
        bucket2 = Bucket.create(place_id: place2.id, user_id: @user.id, list_state: 'done')
        get :index
        expect(assigns(:buckets)).to eq([bucket1])
      end
    end
  end
  
  describe "POST create" do
    context "with authenticated user" do
      let(:place) { Fabricate(:place) }
      before do
        @user = Fabricate(:user)
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(@user)
      end
      it "creates a bucket item associated with the current user" do
        post :create, place_id: place.id
        expect(Bucket.first.user).to eq(@user)
      end    
    end
  end  
  
  describe 'PUT update' do
    context "with authenticated user" do
      let(:place) { Fabricate(:place) }
      before do
        @user = Fabricate(:user)
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(@user)
      end  
      it 'changes the list state' do
        bucket = Bucket.create(place_id: place.id, user_id: @user.id, list_state: 'todo')
        put :update, {id: bucket.id, bucket: { list_state: 'done' }}
        expect(bucket.reload.list_state).to eq('done')
      end
    end
  end
end