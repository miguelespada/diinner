require "rails_helper" 
describe Restaurant do

  before(:each) do
    allow(Pony).to receive(:deliver)
    @admin = FactoryGirl.create(:admin)
  end

  describe "#restaurant?" do
    it "has a restaurant factory" do
      FactoryGirl.create(:restaurant)
      expect(Restaurant.count).to eq 1
    end

    it "has a name" do
      restaurant = FactoryGirl.create(:restaurant)
      expect(restaurant.name).not_to be nil
    end

    it "adds a log entry after creation" do
      FactoryGirl.create(:restaurant, :name => "My restaurant")
      expect(Log.count).to eq 1
    end

    it "does not send an email to the admin after creation" do
      expect(Pony).not_to receive(:mail)
      FactoryGirl.create(:restaurant, :name => "My restaurant")
    end
  end
end
