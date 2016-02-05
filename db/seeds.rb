  def create_admin
  if Admin.count == 0
    Admin.create(email: "admin@diinner.com", password: "12345678")
  end
  p "---ADMIN DATA---"
  p "Email: " + Admin.first.email
  p "Password: 12345678"
  p "----------------"
end

create_admin

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
    city = City.all.sample
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

def valid_card
  {card: {
  name: "Rodrigo Rato",
  number: "4012888888881881",
  exp_month: '09',
  exp_year: '2020',
  cvc: '123'
  }}
end

def invalid_card
 {card: {
  name: "Rodrigo Rato",
  number: "4000000000000002",
  exp_month: '09',
  exp_year: '2020',
  cvc: '123'
  }}
end

def delete_all
  Restaurant.__elasticsearch__.client.indices.delete index: Restaurant.index_name rescue nil
  User.__elasticsearch__.client.indices.delete index: User.index_name rescue nil

  Restaurant.__elasticsearch__.create_index! index: Restaurant.index_name
  User.__elasticsearch__.create_index! index: User.index_name
 

  PublicActivity::Activity.delete_all
  City.delete_all
  Menu.delete_all
  Table.delete_all
  Restaurant.delete_all
  User.delete_all
  Reservation.delete_all
  Payment.delete_all
  Company.delete_all
end

def create_basic_context
  @city = FactoryGirl.create(:city)
  @restaurant = FactoryGirl.create(:restaurant, city: @city)

  @restaurant.menus.create(FactoryGirl.build(:menu).attributes)
  @menu = @restaurant.menus.first
  @restaurant.tables.create(FactoryGirl.build(:table, :for_today, menu: @menu).attributes)
  
  @table = @restaurant.tables.first

  @he = FactoryGirl.create(:user, gender: :male)
  @she = FactoryGirl.create(:user, gender: :female)
end

def create_last_minute_context_2_2
  delete_all
  create_basic_context

  @he.update_customer_information!(Stripe::Token.create(valid_card).id)
  @she.update_customer_information!(Stripe::Token.create(valid_card).id)

  reservation =  FactoryGirl.create(:reservation, user: @he, table: @table, date: 2.days.ago)
  reservation.companies.create(age: 35, gender: :male)
  # reservation.companies.create(age: 30, gender: :male)
  reservation.save!

  reservation =  FactoryGirl.create(:reservation, user: @she, table: @table, date: 3.days.ago)
  reservation.companies.create(age: 30, gender: :female)
  reservation.save!

  TableManager.process_today_tables
end

def create_last_minute_context_2_3
  delete_all
  create_basic_context

  @he.update_customer_information!(Stripe::Token.create(valid_card).id)
  @she.update_customer_information!(Stripe::Token.create(valid_card).id)

  reservation =  FactoryGirl.create(:reservation, user: @he, table: @table, date: 2.days.ago)
  reservation.companies.create(age: 35, gender: :male)
  reservation.companies.create(age: 30, gender: :female)
  reservation.save!

  reservation =  FactoryGirl.create(:reservation, user: @she, table: @table, date: 3.days.ago)
  reservation.companies.create(age: 30, gender: :female)
  reservation.save!

  TableManager.process_today_tables
end
def create_last_minute_context_3_2
  delete_all
  create_basic_context

  @he.update_customer_information!(Stripe::Token.create(valid_card).id)
  @she.update_customer_information!(Stripe::Token.create(valid_card).id)

  reservation =  FactoryGirl.create(:reservation, user: @he, table: @table, date: 2.days.ago)
  reservation.companies.create(age: 35, gender: :male)
  reservation.companies.create(age: 30, gender: :male)
  reservation.save!

  reservation =  FactoryGirl.create(:reservation, user: @she, table: @table, date: 3.days.ago)
  reservation.companies.create(age: 30, gender: :female)
  reservation.save!

  TableManager.process_today_tables
end
def last_minute_reservation card
  other_she = FactoryGirl.create(:user, gender: :female)
  other_she.update_customer_information!(Stripe::Token.create(card).id)
  FactoryGirl.create(:reservation, user: other_she, table: @table)
end

def create_last_minute_context_2_1
  delete_all
  create_basic_context

  @he.update_customer_information!(Stripe::Token.create(valid_card).id)
  @she.update_customer_information!(Stripe::Token.create(valid_card).id)

  reservation =  FactoryGirl.create(:reservation, user: @he, table: @table, date: 2.days.ago)
  reservation.save!

  reservation =  FactoryGirl.create(:reservation, user: @she, table: @table, date: 3.days.ago)
  reservation.companies.create(age: 30, gender: :female)
  reservation.save!

  TableManager.process_today_tables
end

def there_is_one_table_for_tomorrow
  delete_all
  create_basic_context
  @restaurant.tables.create(FactoryGirl.build(:table, :for_tomorrow, menu: @menu).attributes)
end

def there_is_one_reservation
  delete_all
  create_basic_context
  @restaurant.tables.create(FactoryGirl.build(:table, :for_tomorrow, menu: @menu).attributes)
  
  reservation =  FactoryGirl.create(:reservation, user: @he, table: @restaurant.tables.last, date: 2.days.ago)
  reservation.save!
end

def full_table_for_today
  delete_all
  create_basic_context

  @he.update_customer_information!(Stripe::Token.create(valid_card).id)
  @she.update_customer_information!(Stripe::Token.create(valid_card).id)

  reservation = FactoryGirl.create(:reservation, user: @he, table: @restaurant.tables.first, date: 2.days.ago)
  reservation.companies.create(age: 30, gender: :male)
  reservation.companies.create(age: 30, gender: :male)
  reservation.save!

  reservation = FactoryGirl.create(:reservation, user: @she, table: @restaurant.tables.first, date: 1.days.ago)
  reservation.companies.create(age: 30, gender: :female)
  reservation.companies.create(age: 30, gender: :female)
  reservation.save!
end

 # there_is_one_table_for_tomorrow
# there_is_one_reservation
#
# create_last_minute_context_2_2
# last_minute_reservation valid_card
#
#  full_table_for_today

create_last_minute_context_3_2