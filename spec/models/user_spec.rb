require 'rails_helper'

RSpec.describe User, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username).case_insensitive }
end
