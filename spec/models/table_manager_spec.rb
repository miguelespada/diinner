require "rails_helper"

describe TableManager do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @restaurant = FactoryGirl.create(:restaurant, :with_tables)
    @table = @restaurant.tables.first
    @reservation = FactoryGirl.create(:reservation, user: @user, table: @table)
    @valid_card =  {card: {
        name: "Rodrigo Rato",
        number: "4012888888881881",
        exp_month: '09',
        exp_year: '2020',
        cvc: '123'
    }}
  end

  it "returns today tables" do
    FactoryGirl.create(:table, date: Date.tomorrow)
    expect(Table.count).to eq 2
    expect(TableManager.today_tables.count).to eq 1
  end

end

