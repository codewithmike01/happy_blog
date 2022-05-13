require 'spec_helper'
require 'rails_helper'

RSpec.describe 'User Show:', type: :feature do
  before(:each) do
    visit new_user_session_path
    user = User.create!(name: 'Jonyole', email: 'john105908@gmail.com', confirmed_at: Time.now, password: 'password',
                        password_confirmation: 'password', bio: 'okay alright', photo: 'https://photo', posts_counter: 3, role: ' ')
    fill_in 'email', with: user.name
    fill_in 'Password', with: user.password
    click_button 'Log in'

    post = Post.create!(title: 'Price', text: 'Price life alright', comments_counter: 4, likes_counter: 9,
                        user_id: user.id)
    Comment.create!(text: 'Hello here', user_id: user.id, post_id: post.id)

    visit user_posts_path(user.id)
  end

  it 'can see the profile pix of user' do
    visit page.find('#img')[:src]
    expect(page.status_code).to eq 200
  end

  it 'I can see the user username.' do
    expect(page).to have_content('Jonyole')
  end

  it ' number of posts ' do
    expect(page).to have_content('Number of posts: 3')
  end

  it 'can see post title' do
    expect(page).to have_content('Price')
  end

  it 'can see some of the post body' do
    expect(page).to have_content('Price life alright')
  end

  it 'can see first comment of the post' do
    expect(page).to have_content('Hello here')
  end

  it 'can see how many comments a post has' do
    expect(page).to have_content('Comments: 4')
  end

  it 'can see how many likes a post has' do
    expect(page).to have_content('Likes: 9')
  end

  it 'can see a section for pagination if there are more posts than fit on the view.' do
    expect(page).to have_content('pagination')
  end

  it ' it redirects me to that post show page' do
    visit new_user_session_path
    user = User.create!(name: 'Jonyole', email: 'john1059081@gmail.com', confirmed_at: Time.now, password: 'password',
                        password_confirmation: 'password', bio: 'okay alright', photo: 'https://photo', posts_counter: 3, role: ' ')
    post = Post.create!(title: 'Price', text: 'Price life alright', comments_counter: 4, likes_counter: 9,
                        user_id: user.id)

    fill_in 'email', with: user.name
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit user_posts_path(user.id)

    click_on 'Post #1'

    expect(page).to have_current_path(user_post_path(user.id, post.id))
  end

  describe 'Post Show' do
    before(:each) do
      visit new_user_session_path
      user = User.create!(name: 'Jonyole', email: 'john105068@gmail.com', confirmed_at: Time.now, password: 'password',
                          password_confirmation: 'password', bio: 'okay alright', photo: 'https://photo', posts_counter: 3, role: ' ')
      fill_in 'email', with: user.name
      fill_in 'Password', with: user.password
      click_button 'Log in'

      post = Post.create!(title: 'Price', text: 'Price life alright life alright life alright', comments_counter: 14, likes_counter: 19,
                          user_id: user.id)
      Comment.create!(text: 'Hello here', user_id: user.id, post_id: post.id)

      visit user_post_path(user.id, post.id)
    end

    it 'can see the post title.' do
      expect(page).to have_content('Price')
    end

    it 'Can see who wrote the post' do
      visit new_user_session_path
      user = User.create!(name: 'Jonyole', email: 'john1050978@gmail.com', confirmed_at: Time.now, password: 'password',
                          password_confirmation: 'password', bio: 'okay alright', photo: 'https://photo', posts_counter: 3, role: ' ')
      fill_in 'email', with: user.name
      fill_in 'Password', with: user.password
      click_button 'Log in'

      post = Post.create!(title: 'Price', text: 'Price life alright', comments_counter: 4, likes_counter: 9,
                          user_id: user.id)
      Comment.create!(text: 'Hello here', user_id: user.id, post_id: post.id)

      visit user_post_path(user.id, post.id)

      expect(page).to have_content('by Jonyole')
    end

    it 'can see how many comments a post has' do
      expect(page).to have_content('Comments: 14')
    end

    it 'can see how many likes a post has' do
      expect(page).to have_content('Likes: 19')
    end

    it 'can see the post body.' do
      expect(page).to have_content('Price life alright life alright life alright')
    end

    it ' the username of each commentor.' do
      expect(page).to have_content('Jonyole: Hello here')
    end

    it 'To see comment each commentor left' do
      visit new_user_session_path
      user = User.create!(name: 'Jonyole', email: 'jonyole@gmail.com', confirmed_at: Time.now, password: 'password',
                          password_confirmation: 'password', bio: 'okay alright', photo: 'https://photo', posts_counter: 3, role: ' ')
      fill_in 'email', with: user.name
      fill_in 'Password', with: user.password
      click_button 'Log in'

      post = Post.create!(title: 'Price', text: 'Price life alright life alright life alright', comments_counter: 14, likes_counter: 19,
                          user_id: user.id)

      user2 = User.create!(name: 'Ole', email: 'ole068@gmail.com', confirmed_at: Time.now, password: 'password',
                           password_confirmation: 'password', bio: 'okay alright', photo: 'https://photo', posts_counter: 3, role: ' ')

      user3 = User.create!(name: 'Eve', email: 'Eve8@gmail.com', confirmed_at: Time.now, password: 'password',
                           password_confirmation: 'password', bio: 'okay alright', photo: 'https://photo', posts_counter: 3, role: ' ')

      Comment.create!(text: 'Hello here', user_id: user.id, post_id: post.id)
      Comment.create!(text: 'ole is here', user_id: user2.id, post_id: post.id)
      Comment.create!(text: 'eve passing bye', user_id: user3.id, post_id: post.id)

      visit user_post_path(user.id, post.id)

      expect(page).to have_content('Eve: eve passing bye')
      expect(page).to have_content('Ole: ole is here')
      expect(page).to have_content('Jonyole: Hello here')
    end
  end
end
