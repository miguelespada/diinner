require "rails_helper" 
describe Admin do
  describe "#admin?" do
    it "can create a admin" do
      FactoryGirl.create(:admin)
      expect(Admin.count).to eq 1
    end
  end
end