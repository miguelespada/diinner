require "rails_helper"
describe Menu do

  describe "#menu" do
    before do
      @user = FactoryGirl.create(:user)
      restaurant = FactoryGirl.create(:restaurant, :with_tables, :tables_count => 2)
      @menu = restaurant.menus.first
      @table_0 = restaurant.tables.first
      @table_1 = restaurant.tables.last
    end

    it "is empty?" do
      expect(@menu.empty?).to eq true
    end 

    it "assigns menu" do
      expect(@table_0.menu).to eq :undefined
    end

    context "with reservations" do
      before do
        @user.reservations.create({table: @table_0, price: 20})
        @user.reservations.create({table: @table_0, price: 20})
      end

      it "is not empty?" do
        @user.reservations.create({table: @table_1, price: 40})
        expect(@menu.user_count).to eq 2
        expect(@menu.empty?).to eq false
      end

      it "assigns menu" do
        expect(@table_0.menu.name).to eq "Dummy menu"
        expect(@table_0.menu.price).to eq 20
      end

    end

  end
end