require 'spec_helper'
require 'rails_helper'

RSpec.describe 'Login/user index page:', type: :feature do
  before(:each) do
    visit new_user_session_path

    user = User.create!(name: 'Rose', email: 'hope@gmail.com', confirmed_at: Time.now, password: 'password',
                        password_confirmation: 'password', bio: 'okay alright', photo: 'https://photo', posts_counter: 4, role: ' ')

    fill_in 'email', with: user.name
    fill_in 'Password', with: user.password
    click_button 'Log in'

    user2 = User.create!(name: 'Rose', email: 'love@gmail.com', confirmed_at: Time.now, password: 'password',
                         password_confirmation: 'password', bio: 'okay alright', photo: 'https://photo', posts_counter: 9, role: ' ')
  end

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
    user = User.create!(name: 'Jonyole', email: 'e@gmail.com', confirmed_at: Time.now, password: 'password',
                        password_confirmation: 'password', bio: 'okay alright', photo: 'https://photo', posts_counter: 3, role: ' ')

    fill_in 'email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_current_path('/')
    expect(page).to have_content('Signed in successfully.')
  end

  it 'Can see usename for all user' do
    user2 = User.create!(name: 'Boy', email: 'jle@gmail.com', confirmed_at: Time.now, password: 'password',
                         password_confirmation: 'password', bio: 'okay alright', photo: 'https://photo', posts_counter: 3, role: ' ')
    user2 = User.create!(name: 'Girly', email: 'le@gmail.com', confirmed_at: Time.now, password: 'password',
                         password_confirmation: 'password', bio: 'okay alright', photo: 'https://photo', posts_counter: 3, role: ' ')

    visit '/'
    expect(page).to have_content('Boy')
    expect(page).to have_content('Girly')
  end

  it 'Can see Photo for all user' do
    fill_in 'email', with: 'johnhusee@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit '/'
    page.all('#img').each do |img|
      visit img[:src]
      expect(page.status_code).to eq 200
    end
  end

  it 'Can see Number of Post for all user' do
    visit '/'

    expect(page).to have_content('Number of posts: 4')
    expect(page).to have_content('Number of posts: 9')
  end

  it 'redirected to that user show page, when click on a user' do
    user = User.create!(name: 'Jonum', email: 'johnblinks@gmail.com', confirmed_at: Time.now, password: 'password',
                        password_confirmation: 'password', bio: 'okay alright', photo: 'https://photo', posts_counter: 3, role: ' ')

    visit '/'
    click_on user.name
    expect(page).to have_current_path(user_path(user.id))
  end
end
