# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create_users
  5.times do |n|
    name = Faker::Name.name
    email = Faker::Internet.email
    image_url = Faker::Avatar.image
    birth = Faker::Date.between(20.years.ago, 60.years.ago)
    gender = ["male", "female", "undefined"].sample

    User.create(
      name: name,
      email: email,
      image_url: image_url,
      birth: birth,
      gender: gender
      )
  end

end

def create_restaurants
  10.times do |n|
    name = Faker::Name.name
    description = Faker::Lorem.sentences(1)
    email = Faker::Internet.email
    phone = Faker::PhoneNumber.phone_number
    address = Faker::Address.street_address
    city = ["Madrid", "Barcelona", "Sevilla", "Valencia"].sample
    latitude = rand(37.5...43.0)
    longitude = rand(-6.0...2.0)

    Restaurant.create(
      name: name,
      description: description,
      email: email,
      password: '12345678',
      phone: phone,
      address: address,
      city: city,
      latitude: latitude,
      longitude: longitude
    )
  end
end

create_users
create_restaurants

