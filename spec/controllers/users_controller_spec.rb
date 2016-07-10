require 'rails_helper'

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
end

