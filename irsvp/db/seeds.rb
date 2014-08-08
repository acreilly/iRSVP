# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'
require 'date'

20.times do
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, birthday: Time.at(rand * Time.now.to_i), email: Faker::Internet.email, username: Faker::Internet.user_name, password_hash: Faker::Internet.password)
end

30.times do
  Event.create(title: Faker::Lorem.word, location: Faker::Address.street_address, event_start: Time.at(1406204196 + rand(200000..90000000)), event_finish: Time.at(1406204196 + rand(300000..90000000)), description: Faker::Lorem.word, user_id: (1...12).to_a.sample, latitude: Faker::Address.latitude, longitude: Faker::Address.longitude)
end

