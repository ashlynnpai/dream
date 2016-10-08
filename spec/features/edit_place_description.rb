require 'spec_helper.rb'
include Warden::Test::Helpers


feature 'Edit Place Description' do
  after { Warden.test_reset! }
  scenario 'Signed in as a regular user' do
    user = Fabricate(:user)
    place = Place.create(name: 'Old Place', address: 'Blue Mountain', description: 'A nice place to visit')
    login_as(user)
    visit place_path(place)
    expect(page).not_to have_link('Edit Description')
  end

  scenario 'Signed in as admin' do
    admin = Fabricate(:user, admin: true)
    place = Place.create(name: 'Old Place', address: 'Blue Mountain', description: 'A nice place to visit')
    login_as(admin)
    visit place_path(place)
    expect(page).to have_link('Edit Description')
    click_link('Edit Description')
    expect(page).to have_field('Name')
    expect(page).to have_field('Address')
    expect(page).to have_field('Description')
    fill_in 'Name', :with => 'New Place'
    click_button('Update')
    expect(page).to have_content('New Place')
  end

  scenario 'Signed in as the user who created the place' do
    creator = Fabricate(:user)
    place = Place.create(name: 'Old Place', address: 'Blue Mountain', description: 'A nice place to visit', user_id: creator.id)
    login_as(creator)
    visit place_path(place)
    expect(page).to have_link('Edit Description')
    click_link('Edit Description')
    expect(page).not_to have_field('Name')
    expect(page).not_to have_field('Address')
    expect(page).to have_content('Old Place')
    fill_in 'Description', :with => 'This place is so new.'
    click_button('Update')
    expect(page).to have_content('This place is so new.')
  end
end

