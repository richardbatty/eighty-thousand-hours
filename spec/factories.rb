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
    user
  end

  factory :etkh_application do
    pledge true
  end

  factory :etkh_profile do
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
    draft false
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

  factory :comment do
    user
    post
    body "comment body"
  end
end
