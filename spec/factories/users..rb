FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "sample#{n}" }
    sequence(:email)        { |n| "sample#{n}@sample.com" }
    password { 'password' }
    confirmed_at { Date.today }

    trait :guest do
      name { 'guest' }
      email { 'guest@example.com' }
      password { 'password' }
    end
  end
end