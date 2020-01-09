# frozen_string_literal: true

FactoryBot.define do
  factory :admin do
    email { 'admin@email.com' }
    password { 'testpw' }
  end
end
