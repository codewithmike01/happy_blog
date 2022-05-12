require 'spec_helper'
require 'rails_helper'

RSpec.describe 'User Show:', type: :feature do
  before(:each) do
    visit new_user_session_path
    user = create(:user, photo: 'http://usernewphoto', name: 'Mode')
    fill_in 'email', with: user.name
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit user_path(user.id)
  end

  it 'see the user name' do
    expect(page).to have_content('Mode')
  end

  it 'see the number of post' do
    expect(page).to have_content('Number of posts: 2')
  end

  it 'see the user bio' do
    expect(page).to have_content('Doe')
  end

  it 'see the user profile picture' do
    visit page.find('#img')[:src]
    expect(page.status_code).to eq 200
  end
end
