FactoryBot.define do
  factory :post do
    name { 'John' }
    sequence(:email) { |n| "john#{n}@gmail.com" }
    email_confirmed { true }
    confirmed_at { Time.now }
    password { 'password' }
    password_confirmation { 'password' }
    bio { 'Doe' }
    photo { 'https//jdidj.com' }
    posts_counter { 2 }
    confirm_token { 'Xf-fTjXsCVWjmyHLYa38' }
    role { ' ' }
    trait :admin do
      role { 'admin' }
    end
  end
end