require 'faker'

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'secret'
    password_confirmation 'secret'

    factory :admin do
      admin true
    end

    factory :invalid_user do
      email nil
    end
  end
end
