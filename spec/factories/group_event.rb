FactoryGirl.define do
  factory :group_event do
    user_id 1 
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    location { Faker::Address.street_address }
    starts_on { Faker::Date.forward(1) }
    ends_on { Faker::Date.forward(10) + 1 }
  end
end