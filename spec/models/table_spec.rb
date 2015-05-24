require "rails_helper"
describe Table do

  describe "#user_count" do
    before do
      @user = FactoryGirl.create(:user)
      @restaurant_0 = FactoryGirl.create(:restaurant, :with_tables)
      @table_0 = @restaurant_0.tables.first
      3.times do
        @user.reservations.create({table: @table_0})
      end
    end

    it "returns the reservation list" do
      expect(@table_0.user_count).to eq 3
    end

  end
end