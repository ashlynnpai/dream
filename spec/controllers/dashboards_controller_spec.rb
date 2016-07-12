require 'rails_helper'

RSpec.describe DashboardsController, type: :controller do
  
  context 'with authenticated user' do
    let(:user) { Fabricate(:user) }
    before do
      allow(controller).to receive(:authenticate_user!).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
    end
    
    describe 'GET show' do
      it 'assigns @user' do
        get :show
        expect(assigns(:user)).to eq(user)
      end
      
      it 'renders the show template' do
        get :show
        expect(response).to render_template('show')
      end
    end
  end
end