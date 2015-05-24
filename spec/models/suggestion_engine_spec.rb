require "rails_helper"

describe SuggestionEngine do

  before(:all) do
    @user = FactoryGirl.create(:user)
    @suggestionEngine = SuggestionEngine.new @user
  end

  context "with no tables" do
    it "returns empty list" do
      expect(@suggestionEngine.search(Date.today, 20)).to eq []
    end
  end

  context "with tables" do

    before(:each) do
      restaurant = FactoryGirl.create(:restaurant, :with_tables)
      @table = restaurant.tables.first
    end

    describe "is_on_day?" do
      it "returns empty list" do
        expect(@suggestionEngine.search((@table.date - 1.day).to_date, 20).count).to eq 0
      end

      it "returns the table" do
        expect(@suggestionEngine.search(@table.date.to_date, 20).count).to eq 1
      end
    end

    describe "match_price?" do
      it "returns empty list" do
        expect(@suggestionEngine.search(@table.date.to_date, 40).count).to eq 0
        expect(@suggestionEngine.search(@table.date.to_date, 60).count).to eq 0
      end

      it "assigns correct values to reservation" do
        @reservation = @suggestionEngine.search(@table.date.to_date, 20).first
        expect(@reservation.price).to eq 20
        expect(@reservation.table).to eq @table
        expect(@reservation.user).to eq @user
      end
    end

  end
end