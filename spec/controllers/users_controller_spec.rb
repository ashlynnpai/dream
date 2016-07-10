require 'rails_helper'
require 'pry'

RSpec.describe UsersController, type: :controller do
  
  describe 'GET show' do
    it 'sets @user' do
      user = Fabricate(:user)
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end
    
    it 'renders the show template' do
      user = Fabricate(:user)
      get :show, id: user.id
      expect(response).to render_template('show')
    end
  end
  
  describe 'PUT update' do
    context 'with the current user' do     
      it 'updates the public_profile' do
        user = Fabricate(:user, public_profile: true)
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(user)
        put :update, {id: user.id, user: { public_profile: false }}
        expect(user.reload.public_profile).to eq(false)
      end  
    end
  end
end


