FactoryGirl.define do
  factory :authentication do
    user
    provider "facebook"
    uid "1234"
  end

  factory :cause do
    name "Pirates for Peace"
    website "http://piratesforpeace.com"
  end

  factory :donation do
    amount "9.99"
    cause
    member
  end

  factory :eighty_thousand_hours_application do
    pledge true
  end

  factory :member do
    user
    background "Pirate"
    career_plans "Benevolently dictate the Seven Seas"
    apply_occupation "Ship's Mate"
    apply_career_plans "Cap'n"
    apply_reasons_for_joining "Felt bad for running everyone through and plundering their booty,\
                               and wanted to give something back."
    apply_heard_about_us "LinkedIn"
    apply_spoken_to_existing_member "Ay"
  end

  factory :page do
    title "Home"
    slug "home"
    body "hey"
  end

  factory :post do
    title "Blog post"
    slug "blog-post"
    body "Some content"
    teaser "Teaser content"
    author "Anon"
    id 1
  end

  %w[admin member_admin donation_admin web_admin blog_admin].each do |role|
    factory role, :class => Role do
      name role.to_s.camelize
    end
  end

  factory :user do
    sequence(:name) {|n| "user #{n}" } 
    sequence(:email) {|n| "user#{n}@test.com" }
    password 'please'
    password_confirmation 'please'
    after_build { |user| user.confirm! }
    
    factory :donation_manager do
      roles {|roles| [roles.association(:donation_admin)] }
    end
  end
end
