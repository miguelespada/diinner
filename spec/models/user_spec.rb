require "rails_helper" 
describe User do

  before(:each) do
    allow(Pony).to receive(:deliver)
    @admin = FactoryGirl.create(:admin)
  end

  describe "#user?" do
    it "sends an email to the admin after creation" do
      expect(Pony).to receive(:mail) do |mail|
        expect(mail[:to]).to eq @admin.email
        expect(mail[:subject]).to eq "[Diinner] New user: Dummy user"
      end
      FactoryGirl.create(:user, :name => "Dummy user")
      expect(Log.count).to eq 1
    end

     it "adds a log entry after creation" do
      FactoryGirl.create(:user, :name => "Dummy user")
      expect(Log.count).to eq 1
    end
  end
end
