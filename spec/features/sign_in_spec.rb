require 'spec_helper'

feature "Sign in" do
  
  scenario "Sign in with correct credentials" do
    user1 = Fabricate(:user)
    visit new_user_session_path
    fill_in 'Email', :with => user1.email
    fill_in 'Password', :with => "password"
    click_button 'Sign in'
    expect(page).to have_content "Signed in successfully."
  end
  
end