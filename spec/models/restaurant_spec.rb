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
  

  context "Elasticsearch integration" do
    before do
      Restaurant.__elasticsearch__.create_index! index: Restaurant.index_name, force: true
      FactoryGirl.create(:restaurant)
      Restaurant.__elasticsearch__.refresh_index!
      Restaurant.__elasticsearch__.client.cluster.health wait_for_status: 'yellow'
    end

    describe "#search" do
      it "is indexed by elasticsearch" do
        response = Restaurant.search('*')
        expect(response.results.total).to be 1
      end

      it "can be searched" do
        query = Jbuilder.encode do |json|
          json.query do
            json.match do
            end
          end
        end
      end

    end

    after do
      Restaurant.__elasticsearch__.client.indices.delete index: Restaurant.index_name
    end
  end

end
