require 'rails_helper'

RSpec.describe Place, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  
  it { should validate_presence_of(:name) }

end
