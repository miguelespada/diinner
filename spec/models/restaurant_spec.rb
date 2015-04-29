require "rails_helper" 
describe Restaurant do
  describe "#restaurant?" do
    it "has a restaurant factory" do
      FactoryGirl.create(:restaurant)
      expect(Restaurant.count).to eq 1
    end

    it "has a name" do
      restaurant = FactoryGirl.create(:restaurant)
      expect(restaurant.name).not_to be nil
    end
  end
end
