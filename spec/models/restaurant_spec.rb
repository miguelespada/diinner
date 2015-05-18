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
      Restaurant.destroy_all
      Restaurant.__elasticsearch__.client.indices.delete index: Restaurant.index_name rescue nil
      Restaurant.__elasticsearch__.create_index!

      @restaurant = FactoryGirl.create(:restaurant, latitude: 10, longitude: 10)
      
      Restaurant.__elasticsearch__.refresh_index!
      Restaurant.__elasticsearch__.client.cluster.health wait_for_status: 'yellow'
    end

    it "serializes latitud and longitud" do
      expect(Restaurant.__elasticsearch__.mapping.to_hash[:restaurant][:properties][:location][:type]).to eq "geo_point"
      expect(@restaurant.as_indexed_json[:location][:lat]).to eq 10
      expect(@restaurant.as_indexed_json[:location][:lon]).to eq 10
    end
    
    it "can search nearby restaurants" do
      expect(Restaurant.search('*').results.total).to eq 1
      expect(Restaurant.near(10.001, 10, 10).results.total).to eq 1
      expect(Restaurant.near(20, 30, 10).results.total).to eq 0
    end

    after do
      Restaurant.__elasticsearch__.client.indices.delete index: Restaurant.index_name rescue nil
    end
  end
end
