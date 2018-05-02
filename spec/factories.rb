FactoryBot.define do 
  factory :user do
    sequence(:name) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "12345678" }
    introduction { FFaker::Lorem.paragraph }
    role { "normal" }
  end

  factory :category do 
    sequence(:name) { |n| "category#{n}" }
  end

  factory :article do 
    sequence(:title) { |n| "article#{n}" }
    content { FFaker::Lorem.paragraph }
    authority
    status
    category
  end

  factory :reply do 
    content { FFaker::Lorem.paragraph}
    user
    article
  end

end 