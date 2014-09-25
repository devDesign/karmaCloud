
FactoryGirl.define do
  factory :user do
    user_name    Faker::Internet.user_name
    password     "test"
    name         Faker::Name.name
    email        Faker::Internet.email
    latitude     Faker::Address.latitude
    longitude    Faker::Address.longitude
    karma_total  100
    karma_bank   10000

    factory :user_with_story do
      
      after(:create ) do |user, evaluator|
        create_list(:story_with_comments, 5, user: user)
      end
    end
  end

  factory :story do
    title        Faker::Lorem.sentence
    content      Faker::Lorem.paragraph
    latitude     Faker::Address.latitude
    longitude    Faker::Address.longitude
    mood         "green"  
    user

    factory :story_with_comments do 
      after(:create) do |story, evaluator|
        create_list(:comment, 5, story: story, user: story.user)
      end
    end
  end

  factory :comment do
    user
    story 
    content Faker::Lorem.sentence
  end
end



user = FactoryGirl.create :user_with_story