require "rails_helper" 
describe MultiModelSearch do
  context "Elasticsearch integration" do
    
    before(:all) do
      Restaurant.__elasticsearch__.client.indices.delete index: Restaurant.index_name rescue nil
      User.__elasticsearch__.client.indices.delete index: User.index_name rescue nil
      
      3.times do 
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
        response = MultiModelSearch.search('restaurant')
        expect(response.total).to be 3
      end
      it "searches users" do
        response = MultiModelSearch.search('user')
        expect(response.total).to be 3
      end
    end

    
    after(:all) do
      Restaurant.__elasticsearch__.client.indices.delete index: Restaurant.index_name rescue nil
      User.__elasticsearch__.client.indices.delete index: User.index_name rescue nil
    end

  end
end