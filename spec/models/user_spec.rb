require "rails_helper" 
describe User do
  describe "user" do
    it "can create a user" do
      user = User.new(email: "miguel@dummy.com", password: "12345678")
      user.save!
      expect(User.count).to eq 1
    end
  end
end