# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'test@email.com' }
    password { 'secret' }
    role { :default }
    first_name { 'Bat' }
    last_name { 'Man' }
  end

  factory :expert, class: 'User' do
    email { 'expert@email.com' }
    password { 'secret' }
    role { :expert }
    first_name { 'The' }
    last_name { 'One' }
    biography { 'This is a bio' }
    twitter_handle { 'mytwitter' }
    facebook_handle { 'myfacebook' }
    linkedin_handle { 'mylinkedin' }
    website_link { 'mywebsite.com' }
  end
end
