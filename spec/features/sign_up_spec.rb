require 'spec_helper.rb'

feature "User signs up" do
  
  scenario "Sign up with correct credentials" do
    visit new_user_registration_path
    fill_in 'Username', :with => "Happy Hippo"
    fill_in 'Email', :with => "user1@example.com"
    fill_in 'Password', :with => "password1", :match => :prefer_exact
    fill_in 'Password confirmation', :with => "password1", :match => :prefer_exact
    click_button 'Sign up'
    expect(page).to have_content "Welcome! You have signed up successfully."
  end
  
  scenario "Sign up with incorrect credentials" do
    visit new_user_registration_path
    fill_in 'Username', :with => nil
    fill_in 'Email', :with => "user1@example.com"
    fill_in 'Password', :with => "password1", :match => :prefer_exact
    fill_in 'Password confirmation', :with => "password1", :match => :prefer_exact
    click_button 'Sign up'
    expect(page).to have_content "Please review the problems below:"
  end
  
end