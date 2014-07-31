require 'faker'
require 'date'

10.times do
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, birthday: Time.at(rand * Time.now.to_i), email: Faker::Internet.email, username: Faker::Internet.user_name, password_hash: Faker::Internet.password)
end

20.times do
  Event.create(title: Faker::Lorem.word, location: Faker::Address.street_address, event_start: Time.at(rand * Time.now.to_i), event_finish: Time.at(rand * Time.now.to_i), description: Faker::Lorem.word, user_id: (1...11).to_a.sample, latitude: Faker::Address.latitude, longitude: Faker::Address.longitude)
end

