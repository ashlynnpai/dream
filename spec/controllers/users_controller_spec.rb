require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  
  describe 'GET show' do
    context "if the user's profile is public" do
      it 'sets @user' do
        user = Fabricate(:user, public_profile: true)
        get :show, id: user.id
        expect(assigns(:user)).to eq(user)
      end

      it 'renders the show template' do
        user = Fabricate(:user, public_profile: true)
        get :show, id: user.id
        expect(response).to render_template('show')
      end
    end
    
    context "if the user's profile is private" do
      it 'does not set @user' do
        user = Fabricate(:user, public_profile: false)
        get :show, id: user.id
        expect(assigns(:user)).to be_blank
      end
      
      it 'renders text that the profile is private' do
        user = Fabricate(:user, public_profile: false)
        get :show, id: user.id
        response.body.should match(/That member's profile is private/)
      end
    end
  end
  
  describe 'PUT update' do
    context 'with the current user' do       
      let(:user) { Fabricate(:user) }
      before do
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(user)
      end
      it 'updates the public_profile' do
        put :update, {id: user.id, user: { public_profile: false }}
        expect(user.reload.public_profile).to eq(false)
      end  
    end
  end
end


