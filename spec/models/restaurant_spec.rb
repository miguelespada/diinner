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

  describe "#elasticsearch" do
    before do
      Restaurant.__elasticsearch__.client.indices.delete index: Restaurant.index_name rescue nil
      @restaurant = FactoryGirl.create(:restaurant, latitude: "32.0", longitude: "43.00")
      Restaurant.__elasticsearch__.refresh_index!
      Restaurant.__elasticsearch__.client.cluster.health wait_for_status: 'yellow'
    end
    it "serializes latitud and longitud" do
      expect(JSON.parse(@restaurant.as_indexed_json)["lat_lon"]).to eq "32.0,43.00"
    end
    it "can search nearby restaurants" do
      p Restaurant.count
      p Restaurant.near(32, 42, 10)
    end
  end
end
