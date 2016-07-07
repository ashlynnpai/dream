require 'rails_helper'

RSpec.describe BucketsController, type: :controller do
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
end