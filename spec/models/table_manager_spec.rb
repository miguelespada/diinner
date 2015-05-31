require "rails_helper"

describe TableManager do
  before(:each) do
    @restaurant = FactoryGirl.create(:restaurant, :with_tables)
    @table = @restaurant.tables.first
    @user = FactoryGirl.create(:user, gender: :male)
    @she = FactoryGirl.create(:user, gender: :female)
    @reservation = FactoryGirl.create(:reservation, user: @user, table: @table)
  end

  it "returns today tables" do
    FactoryGirl.create(:table, date: Date.tomorrow)
    expect(Table.count).to eq 2
    expect(TableManager.today_tables.count).to eq 1
  end

  it "cancels partial tables" do
    TableManager.process
    @table.reload
    expect(@table.status).to eq :cancelled
    @reservation.reload
    expect(@reservation.status).to eq :cancelled
  end

  context "with enough reservation" do
    before(:each) do
      FactoryGirl.create(:reservation, user: @user, table: @table)
      FactoryGirl.create(:reservation, user: @she, table: @table)
      FactoryGirl.create(:reservation, user: @she, table: @table)
      allow_any_instance_of(Reservation).to receive(:create_stripe_charge) do
       "123"
      end
    end

    it "does not cancel partial tables" do
      expect(@table.user_count).to eq 4
      expect(@table.status).to eq :plan_closed
      table = TableManager.cancel_partial(TableManager.today_tables).first
      expect(table.user_count).to eq 4
      expect(table.status).to eq :plan_closed
    end

    it "captures payments" do
      TableManager.process
      @table.reload
      expect(@table.status).to eq :plan_closed
    end
  end

end

