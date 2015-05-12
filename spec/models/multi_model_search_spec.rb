require "rails_helper" 
describe MultiModelSearch do
  context "Elasticsearch integration" do
    
    before(:all) do
      Restaurant.delete_all
      User.delete_all
      Restaurant.__elasticsearch__.client.indices.delete index: Restaurant.index_name rescue nil
      User.__elasticsearch__.client.indices.delete index: User.index_name rescue nil
      
      5.times do 
        FactoryGirl.create(:restaurant)
        FactoryGirl.create(:user)
      end

      Restaurant.__elasticsearch__.refresh_index!
      User.__elasticsearch__.refresh_index!

      Restaurant.__elasticsearch__.client.cluster.health wait_for_status: 'yellow'
      User.__elasticsearch__.client.cluster.health wait_for_status: 'yellow'
    end

    describe "#search?" do
      it "searches restaurants" do
        response = MultiModelSearch.search('restaurant_', 1)
        expect(response.total).to be 5
      end
      it "searches users" do
        response = MultiModelSearch.search('user_1', 1)
        expect(response.total).to be 5
      end
    end


    after(:all) do
      Restaurant.__elasticsearch__.client.indices.delete index: Restaurant.index_name rescue nil
      User.__elasticsearch__.client.indices.delete index: User.index_name rescue nil
    end

  end
end