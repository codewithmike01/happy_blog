require 'spec_helper'
require 'rails_helper'

RSpec.describe 'Login/user index page:', type: :feature do
  before(:each) { visit new_user_session_path }
  it 'shows Email' do
    expect(page).to have_selector('input[type = email]')
    expect(page).to have_content('Email')
  end

  it 'shows Password  ' do
    expect(page).to have_selector('input[type = password]')
    expect(page).to have_field('Password')
    expect(page).to have_content('Password')
  end

  it 'shows button submit' do
    expect(page).to have_selector('input[type=submit]')
    expect(page).to have_button('Log in')
  end

  it 'Show error when submit with Empty fields' do
    fill_in 'email', with: ' '
    fill_in 'Password', with: ' '
    click_button 'Log in'

    expect(page).to have_content('Invalid Email or password.')
  end

  it 'Show error when submit with wrong fields values' do
    fill_in 'email', with: 'wrong'
    fill_in 'Password', with: 'wrong'
    click_button 'Log in'
    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_content('Invalid Email or password.')
  end

  it 'Show error when submit with correct fields values' do
    user = create(:user)
    fill_in 'email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_current_path('/')
    expect(page).to have_content('Signed in successfully.')
  end

  it 'Can see usename for all user' do
    login_as(create(:user))
    user = create(:user, name: 'Faith')
    user2 = create(:user, name: 'Sammy')
    visit '/'
    expect(page).to have_content('Faith')
    expect(page).to have_content('Sammy')
  end

  it 'Can see Photo for all user' do
    login_as(create(:user))
    user = create(:user, photo: 'http://Faith')
    user2 = create(:user, photo: 'http://Sammy')
    visit '/'
    page.all('#img').each do |img|
      visit img[:src]
      expect(page.status_code).to eq 200
    end
  end

  it 'Can see Number of Post for all user' do
    login_as(create(:user))
    user = create(:user, posts_counter: 25)
    user2 = create(:user, posts_counter: 3)
    visit '/'
    expect(page).to have_content('Number of posts: 25')
    expect(page).to have_content('Number of posts: 3')
  end

  it 'redirected to that user show page, when click on a user' do
    login_as(create(:user))
    user = create(:user, name: 'Golden')
    visit '/'
    click_on user.name
    expect(page).to have_current_path(user_path(user.id))
  end
  
end


