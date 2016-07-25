require 'rails_helper'

RSpec.describe Photo, type: :model do
  
  describe "#last_three_photos(place)" do
    let(:place) { Fabricate(:place) }
    it 'returns all photos if there are three or less' do
      Fabricate.times(2, :photo, place_id: place.id)
      expect(Photo.last_three_photos(place).count).to eq(2)
    end
    
    it 'returns three photos if there are more than three' do
      Fabricate.times(5, :photo, place_id: place.id)
      expect(Photo.last_three_photos(place).count).to eq(3)
    end   
  end
end



