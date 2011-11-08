FactoryGirl.define do
  factory :user do
    name 'Test User'
    sequence(:email) {|n| "user#{n}@test.com" }
    password 'please'
    password_confirmation 'please'
    pledge true
    # u.after_build { |user| user.confirm! }
  end
end
