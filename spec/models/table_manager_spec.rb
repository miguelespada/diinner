require "rails_helper"

describe TableManager do
  before(:each) do    
    Admin.create(email: "need_one_admin@gmail.com", password: "12345678")

    @restaurant = FactoryGirl.create(:restaurant, :with_tables)
    @table = @restaurant.tables.first
    
    @he = FactoryGirl.create(:user)
    @she = FactoryGirl.create(:user, gender: :female)

    return_value = Hash.new
    return_value[:id] = "123"
    allow_any_instance_of(Reservation).to receive(:create_stripe_charge) do |entity|
      entity.user.customer ? return_value : nil
    end

    allow_any_instance_of(Reservation).to receive(:stripe_capture).and_return return_value
    allow_any_instance_of(Reservation).to receive(:stripe_refund).and_return return_value
    allow(Date).to receive(:today).and_return Date.tomorrow

  end

  it "returns today tables" do
    @reservation = FactoryGirl.create(:reservation, user: @he, table: @table)
    FactoryGirl.create(:table, date: Date.today + 1.day)
    expect(Table.count).to eq 2
    expect(TableManager.today_tables.count).to eq 1
  end

  it "cancels partial tables" do
    @reservation = FactoryGirl.create(:reservation, user: @he, table: @table)
    TableManager.process_today_tables
    TableManager.process_last_minute_tables

    @table.reload
    expect(@table.status).to eq :cancelled
    @reservation.reload
    expect(@reservation.status).to eq :cancelled
    expect(@he.notifications.last.key).to eq "plan.cancel"
  end

  context "with reservations and stripe errors" do
    before(:each) do
      @customer = FactoryGirl.create(:user, :with_customer_id)
      FactoryGirl.create(:reservation, user: @customer, table: @table)
      FactoryGirl.create(:reservation, user: @he, table: @table)
      FactoryGirl.create(:reservation, user: @she, table: @table)
      FactoryGirl.create(:reservation, user: @she, table: @table)
    end

    it "cancel partial tables with payment errors" do
      TableManager.process_today_tables
      @table.reload
      expect(@table.status).to eq :cancelled
      Reservation.each do |r|
        expect(r.status).to eq :cancelled
      end
      expect(@restaurant.notifications.last.key).to eq "table.cancel"
      expect(@customer.notifications.last.key).to eq "plan.cancel"
      expect(@he.notifications.last.key).to eq "plan.cancel"
      expect(@she.notifications.last.key).to eq "plan.cancel"
    end
  end

  context "with reservations" do

    it "confirm plans with no errors" do
      @he = FactoryGirl.create(:user, :with_customer_id)
      @she = FactoryGirl.create(:user, :with_customer_id, gender: :female )
      FactoryGirl.create(:reservation, user: @he, table: @table)
      FactoryGirl.create(:reservation, user: @he, table: @table)
      FactoryGirl.create(:reservation, user: @she, table: @table)
      FactoryGirl.create(:reservation, user: @she, table: @table)

      TableManager.process_today_tables
      TableManager.process_last_minute_tables

      @table.reload
      expect(@table.status).to eq :plan_closed

      Reservation.each do |r|
        expect(r.status).to eq :confirmed
      end

      expect(@restaurant.notifications.last.key).to eq "table.confirm"
      expect(@he.notifications.last.key).to eq "plan.confirm"
      expect(@she.notifications.last.key).to eq "plan.confirm"
    end

    it "confirm plans with companies 2 2" do
      @he = FactoryGirl.create(:user, :with_customer_id)
      @she = FactoryGirl.create(:user, :with_customer_id, gender: :female )
      reservation = FactoryGirl.create(:reservation, user: @he, table: @table)
      reservation.companies.create(age: 35, gender: :male)

      reservation =  FactoryGirl.create(:reservation, user: @she, table: @table)
      reservation.companies.create(age: 35, gender: :female)

      TableManager.process_today_tables

      @table.reload
      expect(@table.status).to eq :plan_closed

      Reservation.each do |r|
        expect(r.status).to eq :confirmed
      end

      expect(@table.user_count).to eq 4
      expect(@restaurant.notifications.last.key).to eq "table.confirm"
      expect(@he.notifications.last.key).to eq "plan.confirm"
      expect(@she.notifications.last.key).to eq "plan.confirm"
    end

    it "confirm plans with companies 3 3" do
      @he = FactoryGirl.create(:user, :with_customer_id)
      @she = FactoryGirl.create(:user, :with_customer_id, gender: :female )
      reservation = FactoryGirl.create(:reservation, user: @he, table: @table)
      reservation.companies.create(age: 35, gender: :male)
      reservation.companies.create(age: 35, gender: :female)

      reservation =  FactoryGirl.create(:reservation, user: @she, table: @table)
      reservation.companies.create(age: 35, gender: :female)
      reservation.companies.create(age: 35, gender: :male)

      TableManager.process_today_tables

      @table.reload
      expect(@table.status).to eq :full

      Reservation.each do |r|
        expect(r.status).to eq :confirmed
      end

      expect(@table.user_count).to eq 6
      expect(@restaurant.notifications.last.key).to eq "table.confirm"
      expect(@he.notifications.last.key).to eq "plan.confirm"
      expect(@she.notifications.last.key).to eq "plan.confirm"
    end

    it "confirm plans with companies 3 2" do
      @he = FactoryGirl.create(:user, :with_customer_id)
      @she = FactoryGirl.create(:user, :with_customer_id, gender: :female )
      reservation = FactoryGirl.create(:reservation, user: @he, table: @table)
      reservation.companies.create(age: 35, gender: :male)

      reservation =  FactoryGirl.create(:reservation, user: @she, table: @table)
      reservation.companies.create(age: 35, gender: :female)
      reservation.companies.create(age: 35, gender: :male)

      TableManager.process_today_tables

      @table.reload
      expect(@table.status).to eq :plan_closed

      Reservation.each do |r|
        expect(r.status).to eq :confirmed
      end

      expect(@table.user_count).to eq 5
      expect(@restaurant.notifications.last.key).to eq "table.confirm"
      expect(@he.notifications.last.key).to eq "plan.confirm"
      expect(@she.notifications.last.key).to eq "plan.confirm"
    end

    it "confirm plans with companies 2 + 1, 2" do
      @he = FactoryGirl.create(:user, :with_customer_id)
      @other_he = FactoryGirl.create(:user, :with_customer_id)
      @she = FactoryGirl.create(:user, :with_customer_id, gender: :female )

      reservation = FactoryGirl.create(:reservation, user: @he, table: @table)
      reservation.companies.create(age: 35, gender: :male)

      reservation =  FactoryGirl.create(:reservation, user: @she, table: @table)
      reservation.companies.create(age: 35, gender: :female)

      reservation = FactoryGirl.create(:reservation, user: @other_he, table: @table)

      TableManager.process_today_tables

      @table.reload
      expect(@table.status).to eq :plan_closed

      Reservation.each do |r|
        expect(r.status).to eq :confirmed
      end

      expect(@table.user_count).to eq 5
      expect(@restaurant.notifications.last.key).to eq "table.confirm"
      expect(@he.notifications.last.key).to eq "plan.confirm"
      expect(@other_he.notifications.last.key).to eq "plan.confirm"
    end


    it "confirm plans with companies 2 + 1, 3" do
      @he = FactoryGirl.create(:user, :with_customer_id)
      @other_he = FactoryGirl.create(:user, :with_customer_id)
      @she = FactoryGirl.create(:user, :with_customer_id, gender: :female )
      reservation = FactoryGirl.create(:reservation, user: @he, table: @table)
      reservation.companies.create(age: 35, gender: :male)

      reservation =  FactoryGirl.create(:reservation, user: @she, table: @table)
      reservation.companies.create(age: 35, gender: :female)
      reservation.companies.create(age: 35, gender: :female)

      reservation =  FactoryGirl.create(:reservation, user: @other_he, table: @table)

      TableManager.process_today_tables

      @table.reload
      expect(@table.status).to eq :full

      Reservation.each do |r|
        expect(r.status).to eq :confirmed
      end

      expect(@table.user_count).to eq 6
      expect(@restaurant.notifications.last.key).to eq "table.confirm"
      expect(@he.notifications.last.key).to eq "plan.confirm"
      expect(@she.notifications.last.key).to eq "plan.confirm"
      expect(@other_he.notifications.last.key).to eq "plan.confirm"
    end

    it "confirm plans with companies 1 + 1 + 1, 2" do
      @he = FactoryGirl.create(:user, :with_customer_id)
      @other_he = FactoryGirl.create(:user, :with_customer_id)
      @other_he_2 = FactoryGirl.create(:user, :with_customer_id)
      @she = FactoryGirl.create(:user, :with_customer_id, gender: :female )

      reservation = FactoryGirl.create(:reservation, user: @he, table: @table)

      reservation =  FactoryGirl.create(:reservation, user: @she, table: @table)
      reservation.companies.create(age: 35, gender: :female)

      reservation =  FactoryGirl.create(:reservation, user: @other_he, table: @table)
      reservation =  FactoryGirl.create(:reservation, user: @other_he_2, table: @table)

      TableManager.process_today_tables

      @table.reload
      expect(@table.status).to eq :plan_closed

      expect(@table.user_count).to eq 5

      expect(@restaurant.notifications.last.key).to eq "table.confirm"
      expect(@he.notifications.last.key).to eq "plan.confirm"
      expect(@she.notifications.last.key).to eq "plan.confirm"
      expect(@other_he.notifications.last.key).to eq "plan.confirm"
      expect(@other_he_2.notifications.last.key).to eq "plan.confirm"
    end

    it "confirm plans with some errors" do
      @he = FactoryGirl.create(:user, :with_customer_id)
      @other_he = FactoryGirl.create(:user, :with_customer_id)
      @she = FactoryGirl.create(:user, :with_customer_id, gender: :female )
      @other_she = FactoryGirl.create(:user, :with_customer_id, gender: :female )

      @error_user = FactoryGirl.create(:user, gender: :female )


      allow(Date).to receive(:today).and_return Date.yesterday

      FactoryGirl.create(:reservation, user: @he, table: @table, date: @table.date)
      FactoryGirl.create(:reservation, user: @other_he, table: @table, date: @table.date)
      FactoryGirl.create(:reservation, user: @she, table: @table, date: @table.date)
      FactoryGirl.create(:reservation, user: @other_she, table: @table, date: @table.date)
      reservation = FactoryGirl.create(:reservation, user: @error_user, table: @table, date: @table.date)

      allow(Reservation).to receive(:created_today?).and_return false

      expect(reservation.is_last_minute?).to eq false

      allow(Date).to receive(:today).and_return Date.tomorrow

      expect(reservation.is_last_minute?).to eq false

      expect(TableManager.today_tables.count).to eq 1
      TableManager.process_today_tables

      @table.reload
      @he.reload
      @other_he.reload
      @she.reload
      @other_she.reload
      @error_user.reload

      expect(@table.status).to eq :plan_closed

      expect(@error_user.reservations.first.status).to eq :cancelled
      expect(@he.reservations.first.status).to eq :confirmed
      expect(@she.reservations.first.status).to eq :confirmed
      expect(@other_he.reservations.first.status).to eq :confirmed
      expect(@other_she.reservations.first.status).to eq :confirmed
 
      expect(@restaurant.notifications.last.key).to eq "table.confirm"
      expect(@he.notifications.last.key).to eq "plan.confirm"
      expect(@she.notifications.last.key).to eq "plan.confirm"
      expect(@other_he.notifications.last.key).to eq "plan.confirm"
      expect(@other_she.notifications.last.key).to eq "plan.confirm"
      expect(@error_user.notifications.last.key).to eq "plan.cancel"
    end

    it "cancel last minute plan" do
      @he = FactoryGirl.create(:user, :with_customer_id)
      @other_he = FactoryGirl.create(:user, :with_customer_id)
      @she = FactoryGirl.create(:user, :with_customer_id, gender: :female )
      @other_she = FactoryGirl.create(:user, :with_customer_id, gender: :female )


      allow(Date).to receive(:today).and_return Date.yesterday
      FactoryGirl.create(:reservation, user: @he, table: @table, date: @table.date)
      FactoryGirl.create(:reservation, user: @other_he, table: @table, date: @table.date)
      FactoryGirl.create(:reservation, user: @she, table: @table, date: @table.date)
      FactoryGirl.create(:reservation, user: @other_she, table: @table, date: @table.date)

      allow(Date).to receive(:today).and_return Date.tomorrow
      expect(TableManager.today_tables.count).to eq 1
      TableManager.process_today_tables

      @table.reload
      @he.reload
      @other_he.reload
      @she.reload
      @other_she.reload

      expect(@table.status).to eq :plan_closed

      @last_minute_user = FactoryGirl.create(:user, :with_customer_id)
      reservation = FactoryGirl.create(:reservation, user: @last_minute_user, table: @table, date: @table.date)

      expect(reservation.is_last_minute?).to eq true
      expect(reservation.closes_last_minute_plan?).to eq false

      TableManager.process_last_minute_tables

      expect(@table.status).to eq :plan_closed

      @table.reload
      @last_minute_user.reload

      expect( @last_minute_user.reservations.first.status).to eq :cancelled
      expect(@he.reservations.first.status).to eq :confirmed
      expect(@she.reservations.first.status).to eq :confirmed
      expect(@other_he.reservations.first.status).to eq :confirmed
      expect(@other_she.reservations.first.status).to eq :confirmed

      expect(@last_minute_user.notifications.last.key).to eq "plan.cancel"
    end

    it "closes last minute plan" do
      @he = FactoryGirl.create(:user, :with_customer_id)
      @other_he = FactoryGirl.create(:user, :with_customer_id)
      @she = FactoryGirl.create(:user, :with_customer_id, gender: :female )
      @other_she = FactoryGirl.create(:user, :with_customer_id, gender: :female )


      allow(Date).to receive(:today).and_return Date.yesterday
      FactoryGirl.create(:reservation, user: @he, table: @table, date: @table.date)
      FactoryGirl.create(:reservation, user: @other_he, table: @table, date: @table.date)
      FactoryGirl.create(:reservation, user: @she, table: @table, date: @table.date)
      FactoryGirl.create(:reservation, user: @other_she, table: @table, date: @table.date)

      allow(Date).to receive(:today).and_return Date.tomorrow
      expect(TableManager.today_tables.count).to eq 1
      TableManager.process_today_tables

      @table.reload
      @he.reload
      @other_he.reload
      @she.reload
      @other_she.reload

      expect(@table.status).to eq :plan_closed

      @last_minute_user = FactoryGirl.create(:user, :with_customer_id)
      @last_minute_she = FactoryGirl.create(:user, :with_customer_id, gender: :female )

      reservation = FactoryGirl.create(:reservation, user: @last_minute_user, table: @table, date: @table.date)

      expect(reservation.closes_last_minute_plan?).to eq false
      expect(reservation.is_last_minute?).to eq true

      reservation = FactoryGirl.create(:reservation, user: @last_minute_she, table: @table, date: @table.date)

      expect(reservation.closes_last_minute_plan?).to eq true

      TableManager.process_table reservation.table

      TableManager.process_last_minute_tables

      expect(@table.status).to eq :full

      @table.reload
      @last_minute_user.reload
      @last_minute_she.reload

      expect(@he.reservations.first.status).to eq :confirmed
      expect(@she.reservations.first.status).to eq :confirmed
      expect(@other_he.reservations.first.status).to eq :confirmed
      expect(@other_she.reservations.first.status).to eq :confirmed
      expect( @last_minute_user.reservations.first.status).to eq :confirmed
      expect( @last_minute_she.reservations.first.status).to eq :confirmed

      expect(@last_minute_user.notifications.last.key).to eq "plan.confirm"
      expect(@last_minute_she.notifications.last.key).to eq "plan.confirm"
    end
    
    it "closes last minute plan with payment errors" do
      @he = FactoryGirl.create(:user, :with_customer_id)
      @other_he = FactoryGirl.create(:user, :with_customer_id)
      @she = FactoryGirl.create(:user, :with_customer_id, gender: :female )
      @other_she = FactoryGirl.create(:user, :with_customer_id, gender: :female )


      allow(Date).to receive(:today).and_return Date.yesterday
      FactoryGirl.create(:reservation, user: @he, table: @table, date: @table.date)
      FactoryGirl.create(:reservation, user: @other_he, table: @table, date: @table.date)
      FactoryGirl.create(:reservation, user: @she, table: @table, date: @table.date)
      FactoryGirl.create(:reservation, user: @other_she, table: @table, date: @table.date)

      allow(Date).to receive(:today).and_return Date.tomorrow
      expect(TableManager.today_tables.count).to eq 1
      TableManager.process_today_tables

      @table.reload
      @he.reload
      @other_he.reload
      @she.reload
      @other_she.reload

      expect(@table.status).to eq :plan_closed

      @last_minute_user = FactoryGirl.create(:user, :with_customer_id)
      @last_minute_she = FactoryGirl.create(:user, gender: :female )

      reservation = FactoryGirl.create(:reservation, user: @last_minute_user, table: @table, date: @table.date)

      expect(reservation.closes_last_minute_plan?).to eq false
      expect(reservation.is_last_minute?).to eq true

      expect(@last_minute_user.reservations.first.status).to eq :pending

      reservation = FactoryGirl.create(:reservation, user: @last_minute_she, table: @table, date: @table.date)

      expect(reservation.closes_last_minute_plan?).to eq true

      TableManager.process_table reservation.table

      TableManager.process_last_minute_tables

      expect(@table.status).to eq :plan_closed

      @table.reload
      @last_minute_user.reload
      @last_minute_she.reload

      # last minute user should be pending
      expect(@last_minute_user.reservations.first.status).to eq :cancelled
      expect(@last_minute_she.reservations.first.status).to eq :cancelled
    end

    it "closes last minute plans with companies 3 2 " do
      @he = FactoryGirl.create(:user, :with_customer_id)
      @she = FactoryGirl.create(:user, :with_customer_id, gender: :female )
      reservation = FactoryGirl.create(:reservation, user: @he, table: @table)
      reservation.companies.create(age: 35, gender: :male)

      reservation =  FactoryGirl.create(:reservation, user: @she, table: @table)
      reservation.companies.create(age: 35, gender: :female)
      reservation.companies.create(age: 35, gender: :male)

      TableManager.process_today_tables

      @table.reload
      expect(@table.status).to eq :plan_closed

      Reservation.each do |r|
        expect(r.status).to eq :confirmed
      end

      expect(@table.user_count).to eq 5
      expect(@restaurant.notifications.last.key).to eq "table.confirm"
      expect(@he.notifications.last.key).to eq "plan.confirm"
      expect(@she.notifications.last.key).to eq "plan.confirm"


      @last_minute_user = FactoryGirl.create(:user, :with_customer_id)

      allow(Date).to receive(:today).and_return Date.tomorrow
      reservation = FactoryGirl.create(:reservation, user: @last_minute_user, table: @table, date: @table.date)

      expect(reservation.closes_last_minute_plan?).to eq true
      expect(reservation.is_last_minute?).to eq true

      TableManager.process_table reservation.table

      expect(@table.status).to eq :full
      expect(@table.user_count).to eq 6
      expect(@last_minute_user.reservations.first.status).to eq :confirmed
    end

    it "closes last minute plans with companies 3 2 with erros" do
      @he = FactoryGirl.create(:user, :with_customer_id)
      @she = FactoryGirl.create(:user, :with_customer_id, gender: :female )
      reservation = FactoryGirl.create(:reservation, user: @he, table: @table)
      reservation.companies.create(age: 35, gender: :male)

      reservation =  FactoryGirl.create(:reservation, user: @she, table: @table)
      reservation.companies.create(age: 35, gender: :female)
      reservation.companies.create(age: 35, gender: :male)

      TableManager.process_today_tables

      @table.reload
      expect(@table.status).to eq :plan_closed

      Reservation.each do |r|
        expect(r.status).to eq :confirmed
      end

      expect(@table.user_count).to eq 5
      expect(@restaurant.notifications.last.key).to eq "table.confirm"
      expect(@he.notifications.last.key).to eq "plan.confirm"
      expect(@she.notifications.last.key).to eq "plan.confirm"


      @last_minute_user = FactoryGirl.create(:user)

      allow(Date).to receive(:today).and_return Date.tomorrow
      reservation = FactoryGirl.create(:reservation, user: @last_minute_user, table: @table, date: @table.date)

      expect(reservation.closes_last_minute_plan?).to eq true
      expect(reservation.is_last_minute?).to eq true

      TableManager.process_table reservation.table

      expect(@table.status).to eq :plan_closed
      expect(@table.user_count).to eq 5
      expect(@last_minute_user.reservations.first.status).to eq :cancelled

      @last_minute_user = FactoryGirl.create(:user, :with_customer_id)
      reservation = FactoryGirl.create(:reservation, user: @last_minute_user, table: @table, date: @table.date)

      expect(reservation.closes_last_minute_plan?).to eq true
      expect(reservation.is_last_minute?).to eq true

      TableManager.process_table reservation.table

      expect(@table.status).to eq :full
      expect(@table.user_count).to eq 6
      expect(@last_minute_user.reservations.first.status).to eq :confirmed
    end




  end

end

