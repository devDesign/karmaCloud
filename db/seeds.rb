
FactoryGirl.define do
  factory :user do
    sequence(:user_name)  {|n| Faker::Internet.user_name + "#{n}"}
    password              Digest::SHA1.hexdigest("test")
    name                  Faker::Name.name
    sequence(:email)      {|n| "#{n}" + Faker::Internet.email}
    sequence(:latitude)   {Faker::Address.latitude}
    sequence(:longitude)  {Faker::Address.longitude}
    karma_total           100
    karma_bank            10000


    factory :user_with_story do
      after(:create ) do |user, evaluator|
        create_list(:story_with_comments, 5, user: user)
      end
    end
  end

  factory :story do
    title        Faker::Lorem.sentence
    content      Faker::Lorem.paragraph
    sequence(:latitude)   {Faker::Address.latitude}
    sequence(:longitude)  {Faker::Address.longitude}
    mood         {["green","red"].sample}
    sequence(:user_name)    {Faker::Name.name}
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



100.times do
  user = FactoryGirl.create :user_with_story
end

  