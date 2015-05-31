require "rails_helper"

describe TableManager do
  before(:each) do
    @restaurant = FactoryGirl.create(:restaurant, :with_tables)
    @table = @restaurant.tables.first
    @he = FactoryGirl.create(:user, gender: :male)
    @she = FactoryGirl.create(:user, gender: :female)
  end

  it "returns today tables" do
    @reservation = FactoryGirl.create(:reservation, user: @he, table: @table)
    FactoryGirl.create(:table, date: Date.tomorrow)
    expect(Table.count).to eq 2
    expect(TableManager.today_tables.count).to eq 1
  end

  it "cancels partial tables" do
    @reservation = FactoryGirl.create(:reservation, user: @he, table: @table)
    TableManager.process
    @table.reload
    expect(@table.status).to eq :cancelled
    @reservation.reload
    expect(@reservation.status).to eq :cancelled
  end

  context "with reservations and stripe errors" do
    before(:each) do
      @customer = FactoryGirl.create(:user, :with_customer_id)
      FactoryGirl.create(:reservation, user: @customer, table: @table)
      FactoryGirl.create(:reservation, user: @he, table: @table)
      FactoryGirl.create(:reservation, user: @she, table: @table)
      FactoryGirl.create(:reservation, user: @she, table: @table)
      allow_any_instance_of(Reservation).to receive(:create_stripe_charge) do |entity|
       entity.user.customer ? "123" : false
      end
    end

    it "does not cancel partial tables" do
      expect(@table.user_count).to eq 4
      expect(@table.status).to eq :plan_closed
      table = TableManager.cancel_partial(TableManager.today_tables).first
      expect(table.user_count).to eq 4
      expect(table.status).to eq :plan_closed
    end

    it "cancel partial tables with payment errors" do
      TableManager.process
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
    before(:each) do
      @he = FactoryGirl.create(:user, :with_customer_id)
      @she = FactoryGirl.create(:user, :with_customer_id, gender: :female )
      FactoryGirl.create(:reservation, user: @he, table: @table)
      FactoryGirl.create(:reservation, user: @he, table: @table)
      FactoryGirl.create(:reservation, user: @she, table: @table)
      FactoryGirl.create(:reservation, user: @she, table: @table)
      allow_any_instance_of(Reservation).to receive(:create_stripe_charge).and_return "123"
      allow_any_instance_of(Reservation).to receive(:stripe_capture).and_return true
    end

    it "does not cancel partial tables" do
      expect(@table.user_count).to eq 4
      expect(@table.status).to eq :plan_closed
      table = TableManager.cancel_partial(TableManager.today_tables).first
      expect(table.user_count).to eq 4
      expect(table.status).to eq :plan_closed
    end

    it "cancel partial tables with payment errors" do
      TableManager.process
      @table.reload
      expect(@table.status).to eq :plan_closed
      Reservation.each do |r|
        expect(r.status).to eq :confirmed
      end

      expect(@restaurant.notifications.last.key).to eq "table.confirmed"
      expect(@he.notifications.last.key).to eq "plan.confirmed"
      expect(@she.notifications.last.key).to eq "plan.confirmed"
    end
  end

end

