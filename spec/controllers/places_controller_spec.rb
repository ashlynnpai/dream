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
end