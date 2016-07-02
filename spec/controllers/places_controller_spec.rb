require 'spec_helper'

describe PlacesController, type: :controller do
  
  describe 'GET index' do
    it 'sets @places' do
      Fabricate.times(10, :place)
      get :index
      expect(Place.count).to eq(10)
    end
  end
  describe 'GET new' do
    it 'sets @place' do
      get :new
      expect(assigns(:place)).to be_a_new(Place)
    end
  end
end