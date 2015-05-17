require "rails_helper" 
describe Log do

  describe "#create?" do
    it "logs object creation" do
      FactoryGirl.create(:restaurant)
      expect(Log.count).to eq 1
      expect(Log.last.action).to eq "new"
    end
  end
  describe "#update?" do
    it "logs object update" do
      restaurant = FactoryGirl.create(:restaurant)
      restaurant.name = "change name"
      restaurant.save!
      expect(Log.count).to eq 2
      expect(Log.last.action).to eq "update"
    end
  end

end