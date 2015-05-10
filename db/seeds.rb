# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create_users
  50.times do |n|
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

create_users