require "rails_helper" 
describe User do


  describe "#user?" do

    before(:each) do
      allow(Pony).to receive(:deliver)
      @admin = FactoryGirl.create(:admin)
    end

    xit "sends an email to the admin after creation" do
      expect(Pony).to receive(:mail) do |mail|
        expect(mail[:to]).to eq @admin.email
        expect(mail[:subject]).to eq "[Diinner] New user: Dummy user"
      end
    end


  end

  describe "#test response?" do

    before(:each) do 
      @user = FactoryGirl.create(:user, gender: "male")
      @test = FactoryGirl.create(:test, gender: "male")
    end

    it "can response a test" do
      test_response = TestResponse.create(response: @test.caption_A, user: @user, test: @test)
      expect(@user.test_completed.count).to eq 1
      expect(@test.responses.count).to eq 1
    end 

    it "cannot response a test twice" do
      test_response = TestResponse.create(response: @test.caption_A, user: @user, test: @test)
      expect(@user.test_pending.count).to eq 0
    end

    it "cannot response other gender tests" do
      @test_female = FactoryGirl.create(:test, gender: "female")
      expect(@user.test_pending.count).to eq 1
    end

    it "can response undefined gender tests" do
      FactoryGirl.create(:test, gender: "undefined")
      expect(@user.test_pending.count).to eq 2
    end

    it "can response multple tests" do
      @test2 = FactoryGirl.create(:test, gender: "male")
      TestResponse.create(response: @test.caption_A, user: @user, test: @test)
      TestResponse.create(response: @test2.caption_A, user: @user, test: @test2)
      expect(@user.test_completed.count).to eq 2
      expect(@user.test_pending.count).to eq 0
    end
  end

  describe "#age?" do
    before(:each) do 
      @user = FactoryGirl.create(:user)
      @other = FactoryGirl.create(:user, birth: 30.years.ago)
    end

    it "returns the correct age" do
      expect(@other.age).to be 30
    end 


    it "matches age" do
      @user.preference = FactoryGirl.build(:preference, min_age: 20, max_age: 40)
      expect(@user.matches_age_preference?(@other)).to be true
    end 

    it "does not match age" do
      @user.preference = FactoryGirl.build(:preference, min_age: 31, max_age: 40)
      expect(@user.matches_age_preference?(@other)).to be false
      @user.preference = FactoryGirl.build(:preference, min_age: 20, max_age: 29)
      expect(@user.matches_age_preference?(@other)).to be false
    end 
  end

  describe "#affinity?" do
    before(:each) do 
      @user = FactoryGirl.create(:user)
      @other = FactoryGirl.create(:user)
      @test_0 = FactoryGirl.create(:test)
      @test_1 = FactoryGirl.create(:test)
    end

    it "with no responses" do
      expect(@other.affinity(@user)).to be 100
      expect(@user.affinity(@other)).to be 100
    end

    it "affinity maximum" do
      TestResponse.create(response: @test_0.caption_A, user: @user, test: @test_0)
      TestResponse.create(response: @test_1.caption_A, user: @other, test: @test_0)
      
      expect(@other.affinity(@user)).to be 100
      expect(@user.affinity(@other)).to be 100
    end
  end
end
