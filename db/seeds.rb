
FactoryGirl.define do
  factory :user do
    user_name    Faker::Internet.user_name
    password     Faker::Internet.password(10, 20)
    name         Faker::Name.name
    email        Faker::Internet.email
    latitude     Faker::Address.latitude
    longitude    Faker::Address.longitude
    karma_total  rand(100)
    karma_bank   rand(500_000)
  end
end


FactoryGirl.define do
  factory :story do
    title        Faker::Lorem.sentence(3)
    content      Faker::Lorem.paragraph
    latitude     Faker::Address.latitude
    longitude    Faker::Address.longitude
    mood         # green or red
    user    
  end
end

