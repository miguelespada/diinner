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

    it "sends an email to the admin after creation" do
      expect(Pony).to receive(:mail) do |mail|
        expect(mail[:to]).to eq @admin.email
        expect(mail[:subject]).to eq "[Diinner] New restaurant: My restaurant"
      end
      restaurant = FactoryGirl.create(:restaurant, :name => "My restaurant")
    end
  end
end
