require 'rails_helper'

RSpec.describe DashboardsController, type: :controller do
  
  context 'with authenticated user' do
    describe 'GET show' do
      it 'assigns @user' do
        user = Fabricate(:user, public_profile: true)
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(user)
        get :show
        expect(assigns(:user)).to eq(user)
      end
      it 'renders the show template' do
        user = Fabricate(:user, public_profile: true)
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(user)
        get :show
        expect(response).to render_template('show')
      end
    end
  end
end