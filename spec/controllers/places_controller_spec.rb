require 'spec_helper'

describe PlacesController, type: :controller do
  
  describe 'GET index' do
    it 'sets @places' do
      place = Fabricate(:place)
      place2 = Fabricate(:place)
      get :index
      expect(assigns(:places)).to eq([place, place2])
    end
    
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end
    
  describe 'GET search' do
    let(:user) { Fabricate(:user) }
    before do
      allow(controller).to receive(:authenticate_user!).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
    end
    it 'sets @place' do
      get :search
      expect(assigns(:place)).to be_a_new(Place)
    end
  end
  
  describe 'POST create' do
    let(:user) { Fabricate(:user) }
    before do
      allow(controller).to receive(:authenticate_user!).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
    end
 
    context 'with valid input' do
      it 'creates a place' do
        post :create, place: Fabricate.attributes_for(:place)
        expect(Place.count).to eq(1)
      end
    end
    
    context 'with invalid input' do
      it 'does not create a new place' do
        post :create, place: Fabricate.attributes_for(:place, name: nil)
        expect(Place.count).to eq(0)
      end
      
     it 'renders the new template' do
        post :create, place: Fabricate.attributes_for(:place, name: nil)
        expect(response).to render_template('search')
      end
    end
  end

  describe 'GET show' do
    it 'sets @place' do
      place = Fabricate(:place)
      get :show, id: place.id
      expect(assigns(:place)).to eq(place)
    end
    
    it 'renders the show template' do
      place = Fabricate(:place)
      get :show, id: place.id
      expect(response).to render_template('show')
    end
  end
  
  describe 'GET edit' do
    let(:user) { Fabricate(:user) }
    before do
      allow(controller).to receive(:authenticate_user!).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
    end
    
    context 'with the current user' do
      it 'sets @place' do
        place = Fabricate(:place, user_id: user.id)
        get :edit, id: place.id
        expect(assigns(:place)).to eq(place)
      end

      it 'renders the edit template' do
        place = Fabricate(:place, user_id: user.id)
        get :edit, id: place.id
        expect(response).to render_template('edit')
      end
    end
    
    context 'not with the current user' do
      it 'renders an error' do
        creator = Fabricate(:user)
        place = Fabricate(:place, user_id: creator.id)
        get :edit, id: place.id
        expect(response).to be_forbidden
      end
    end
  end
  
  describe 'PUT update' do
    let(:user) { Fabricate(:user) }
    before do
      allow(controller).to receive(:authenticate_user!).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
    end
    
    context 'with the current user' do
      it 'updates the attribute' do
        place = Fabricate(:place, description: 'old description', user_id: user.id)
        put :update, {id: place.id, place: { description: 'new description' }}
        expect(place.reload.description).to eq('new description')
      end
    end
    
   context 'not with the current user' do
      it 'renders an error' do
        creator = Fabricate(:user)
        place = Fabricate(:place, name: 'old name', user_id: creator.id)
        put :update, {id: place.id, place: { name: 'new name' }}
        expect(response).to be_forbidden
      end
    end
    
    context 'with invalid input' do      
      it 'does not update a locked attribute' do
        place = Fabricate(:place, name: 'old name', user_id: user.id)
        put :update, {id: place.id, place: { name: 'new name' }}
        expect(place.reload.name).to eq('old name')
      end
    end
  end
end  
