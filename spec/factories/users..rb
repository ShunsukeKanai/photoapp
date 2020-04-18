FactoryBot.define do
  factory :user do
    name {'testuser'}
    email {'test1@example.com'}
    password {'password'}
    confirmed_at { Date.today }
  end
end