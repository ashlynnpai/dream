require 'spec_helper'

describe PlacesController, type: :controller do
  
  describe 'GET index' do
    it 'sets @places' do
      place = Place.create
      get :index
      expect(assigns(:places)).to eq([place])
    end
    
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
  
  describe 'GET new' do
    it 'sets @place' do
      get :new
      expect(assigns(:place)).to be_a_new(Place)
    end
  end
  
  describe 'POST create' do
    it 'creates a place' do
      post :create, place: Fabricate.attributes_for(:place)
      expect(Place.count).to eq(1)
    end
  end
end