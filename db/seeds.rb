if Rails.env.development?
  event_list = [
      {user_id: 1, location: Faker::Address.street_address(true), starts_on: Faker::Date.forward(7), duration: 2},
      {user_id: 1, name: Faker::Name.name, description: Faker::Lorem.paragraph, ends_on: Faker::Date.forward(20), duration: 14},
      {user_id: 1,
       name: Faker::Name.name,
       description: Faker::Lorem.paragraph,
       location: Faker::Address.street_address(true),
       starts_on: Faker::Date.forward(1),
       ends_on: Faker::Date.forward(50)
      }
  ]
  event_list.each do |p|
    GroupEvent.create(p)
  end
end