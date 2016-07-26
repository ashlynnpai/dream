require 'rails_helper'

RSpec.describe GalleriesController, type: :controller do
  describe 'GET index' do
    let(:place) { Fabricate(:place) }
    it 'sets @place' do
      get :index, place_id: place.id
      expect(assigns(:place)).to eq(place)
    end
  end
end