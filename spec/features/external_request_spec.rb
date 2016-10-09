require 'spec_helper'

feature 'External request' do
  it 'makes an API call to Bing' do
    uri = URI('http://dev.virtualearth.net/REST/v1/Locations/US/WA/98052/Redmond/1%20Microsoft%20Way?o=xml&key=BingMapsKey')

    response = Net::HTTP.get(uri)

    expect(response).to be_an_instance_of(String)
  end
end