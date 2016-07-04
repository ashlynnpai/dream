require 'spec_helper'

describe PlacesController, type: :controller do
  
  describe 'GET index' do
    it 'sets @places' do
      place = Place.create
      get :index
      expect(assigns(:places)).to eq([place])
    end
    
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end
    
  describe 'GET new' do
    before do
      @user = Fabricate(:user)
      sign_in @user
    end
    it 'sets @place' do
      get :new
      expect(assigns(:place)).to be_a_new(Place)
    end
  end
  
  describe 'POST create' do
    before do
      @user = Fabricate(:user)
      sign_in @user
    end
    it 'creates a place' do
      post :create, place: Fabricate.attributes_for(:place)
      expect(Place.count).to eq(1)
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
    before do
      @user = Fabricate(:user)
      sign_in @user
    end
    
    context 'with the current user' do
      it 'sets @place' do
        place = Fabricate(:place, user_id: @user.id)
        get :edit, id: place.id
        expect(assigns(:place)).to eq(place)
      end

      it 'renders the edit template' do
        place = Fabricate(:place, user_id: @user.id)
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
    before do
      @user = Fabricate(:user)
      sign_in @user
    end
    
    context 'with the current user' do
      it 'updates the attribute' do
        place = Fabricate(:place, name: 'old name', user_id: @user.id)
        put :update, {id: place.id, place: { name: 'new name' }}
        expect(place.reload.name).to eq('new name')
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
  end
end  
