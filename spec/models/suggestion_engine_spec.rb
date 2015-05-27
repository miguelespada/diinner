require "rails_helper"

describe SuggestionEngine do

  before(:all) do
    @user = FactoryGirl.create(:user)
    @params = {:date => "2015-12-20",
               :price =>"20"}
    @company = {"0" => {:gender => "female", :age => "20"},
               "1" => {:gender => "male", :age =>"30"}}
    @params[:companies_attributes] = @company
  end

  context "with no tables" do
    it "returns empty list" do
      @suggestionEngine = SuggestionEngine.new @user, @params
      expect(@suggestionEngine.search).to eq []
    end
  end

  context "with tables" do

    before(:each) do
      restaurant = FactoryGirl.create(:restaurant, :with_tables)
      @table = restaurant.tables.first
    end

    describe "is_on_day?" do
      it "returns empty list" do
        @params[:date] = (@table.date + 1.day).to_s
        @suggestionEngine = SuggestionEngine.new @user, @params
        expect(@suggestionEngine.search.count).to eq 0
      end

      it "returns the table" do
        @params[:date] = @table.date.to_s
        @suggestionEngine = SuggestionEngine.new @user, @params
        expect(@suggestionEngine.search.count).to eq 1
      end
    end

    describe "match_price?" do
       before(:each) do
          @params = {:date => "2015-12-20",
                     :price =>"20"}
          @company = {"0" => {:gender => "female", :age => "20"},
                     "1" => {:gender => "male", :age =>"30"}}
          @params[:companies_attributes] = @company
          @params[:date] = @table.date.to_s
        end

      it "returns empty list" do
        @params[:price] = 40
        @suggestionEngine = SuggestionEngine.new @user, @params
        expect(@suggestionEngine.search.count).to eq 0
        @params[:price] = 60
        @suggestionEngine = SuggestionEngine.new @user, @params
        expect(@suggestionEngine.search.count).to eq 0
      end

      it "assigns correct values to reservation" do
        @suggestionEngine = SuggestionEngine.new @user, @params
        @reservation = @suggestionEngine.search.first

        expect(@reservation.price).to eq 20
        expect(@reservation.table).to eq @table
        expect(@reservation.user).to eq @user
        expect(@table.reservations).to eq []
      end
    end

    context "with company" do
      before(:all) do
        restaurant = FactoryGirl.create(:restaurant, :with_tables)
        @table = restaurant.tables.first
      end
      before(:each) do
        @params[:date] = @table.date.to_s
        @params[:price] = 20
      end
      it "returns the table" do
        @company = {"0" => {:gender => "female", :age => "20"},
                   "1" => {:gender => "male", :age =>"30"}}
        @params[:companies_attributes] = @company
        @suggestionEngine = SuggestionEngine.new @user, @params

        expect(@suggestionEngine.search.count).to eq 1
      end

      it "does not return the table with too many users" do
        @company = {"0" => {:gender => "female", :age => "20"},
                   "1" => {:gender => "male", :age =>"30"},
                   "2" => {:gender => "female", :age => "20"},
                   "3" => {:gender => "male", :age =>"30"},
                   "4" => {:gender => "female", :age => "20"},
                   "5" => {:gender => "male", :age =>"30"}
                    }
        @params[:companies_attributes] = @company
        @suggestionEngine = SuggestionEngine.new @user, @params

        expect(@suggestionEngine.search.count).to eq 0
      end

      it "accepts male and famale" do
        @company = {"0" => {:gender => "female", :age => "20"},
                   "1" => {:gender => "male", :age =>"30"},
                   "2" => {:gender => "female", :age => "20"},
                   "3" => {:gender => "female", :age => "20"},
                   "4" => {:gender => "male", :age =>"30"}
                    }
        @params[:companies_attributes] = @company
        @suggestionEngine = SuggestionEngine.new @user, @params

        expect(@suggestionEngine.search.count).to eq 1
      end
    end

  end
end