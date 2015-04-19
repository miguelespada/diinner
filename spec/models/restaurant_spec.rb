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
    before(:all) do
      Restaurant.__elasticsearch__.create_index! index: Restaurant.index_name, force: true
      3.times do 
        FactoryGirl.create(:restaurant)
      end
      FactoryGirl.create(:restaurant, name: "MyDummy restaurant")

      Restaurant.__elasticsearch__.refresh_index!
      Restaurant.__elasticsearch__.client.cluster.health wait_for_status: 'yellow'
    end

    describe "#search" do
      it "is indexed by elasticsearch" do
        response = Restaurant.search('name:*')
        expect(response.results.total).to be 4
      end

      it "can be searched using DSL" do
        query = Jbuilder.encode do |json|
          json.query do
            json.match do
              json.name do
                json.query "MyDumxx"
                json.fuzziness 2
                json.prefix_length 3
              end
            end
          end
        end
        response = Restaurant.search(query)
        expect(response.results.total).to be 1
      end
    end


    after(:all) do
      Restaurant.__elasticsearch__.client.indices.delete index: Restaurant.index_name
    end
  end

end
