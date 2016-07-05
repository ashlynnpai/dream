require 'rails_helper'

RSpec.describe Place, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:description) }
  
  describe '#rating' do
    it 'returns the average rating if there are ratings present' do
      place = Fabricate(:place)
      user = Fabricate(:user)
      comment1 = Fabricate(:comment, user: user, place: place, rating: 1)
      comment2 = Fabricate(:comment, user: user, place: place, rating: 5)
      expect(place.rating).to eq(3.0) 
    end
    
    it 'returns nil if there are no ratings present' do
      place = Fabricate(:place)
      user = Fabricate(:user)
      comment1 = Fabricate(:comment, user: user, place: place, rating: nil)
      expect(place.rating).to eq(nil) 
    end
  end
  

end
