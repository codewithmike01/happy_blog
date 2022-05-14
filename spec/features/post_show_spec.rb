require 'spec_helper'
require 'rails_helper'

RSpec.describe 'Test test' do
  before(:each) do
    visit new_user_session_path
  end

  it 'see redirect click user post show' do
    user = User.create!(name: 'Great', email: 'great8@gmail.com', confirmed_at: Time.now, password: 'password',
                        password_confirmation: 'password', bio: 'okay alright', photo: 'https://photo', posts_counter: 3, role: ' ')
    fill_in 'email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    post = Post.create!(title: 'Real stressed', text: 'Price', comments_counter: 4, likes_counter: 9,
                        user_id: user.id)
    visit user_posts_path(user.id)

    click_on 'Post #1'

    expect(page).to have_current_path(user_post_path(user.id, post.id))
    expect(page).to have_content('Post #1')
  end

  it 'click on see all and redirects me' do
    user = User.create!(name: 'Great', email: 'great8@gmail.com', confirmed_at: Time.now, password: 'password',
                        password_confirmation: 'password', bio: 'okay alright', photo: 'https://photo', posts_counter: 3, role: ' ')

    fill_in 'email', with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'

    visit user_path(user.id)

    click_on 'view all'

    expect(page).to have_current_path(user_posts_path(user.id))
  end
end
