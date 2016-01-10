
  require "rails_helper" 
describe User do
  before(:each) do 
    @user = FactoryGirl.create(:user)
    @other = FactoryGirl.create(:user)

    @test_0 = FactoryGirl.create(:test, extraversion: 2, educacion: -2, freakismo: 1, hipsterismo: -1)
    @test_1 = FactoryGirl.create(:test, extraversion: 1, educacion: -2, freakismo: 0, hipsterismo: -1)
  end

  describe "#user score" do
    it "it computes the average" do
      TestResponse.create(user: @user, test: @test_0, response: @test_0.caption_A)
      TestResponse.create(user: @user, test: @test_1, response: @test_1.caption_B)
      
      expect(@user.profile :extraversion).to be 0.5
      expect(@user.profile :educacion).to be 0.0
      expect(@user.profile :freakismo).to be 0.5
      expect(@user.profile :hipsterismo).to be 0.0
    end
  end

  describe "#user affinity?" do
    it "with no responses" do
      expect(@other.affinity(@user)).to be 1.0
      expect(@user.affinity(@other)).to be 1.0
    end

    it "high affinity" do
      TestResponse.create(user: @user, test: @test_0, response: @test_0.caption_A)
      TestResponse.create(user: @user, test: @test_1, response: @test_1.caption_B)
      TestResponse.create(user: @other, test: @test_0, response: @test_0.caption_A)
      TestResponse.create(user: @other, test: @test_1, response: @test_1.caption_B)

      expect(@other.affinity(@user)).to be 1.0
      expect(@user.affinity(@other)).to be 1.0
    end

    it "low affinity" do
      TestResponse.create(user: @user, test: @test_0, response: @test_0.caption_A)
      TestResponse.create(user: @user, test: @test_1, response: @test_1.caption_B)
      TestResponse.create(user: @other, test: @test_0, response: @test_0.caption_B)
      TestResponse.create(user: @other, test: @test_1, response: @test_1.caption_A)

      expect(@other.affinity(@user)).to be 0.875
    end

    it "worst affinity" do
      @test_0 = FactoryGirl.create(:test, extraversion: 2, educacion: 2, freakismo: 2, hipsterismo: 2)

      TestResponse.create(user: @user, test: @test_0, response: @test_0.caption_A)
      TestResponse.create(user: @other, test: @test_0, response: @test_0.caption_B)

      expect(@other.affinity(@user)).to be 0.0
    end
  end

  describe "#reservation affinity?" do

    it "with same plan" do
      r_0 =  FactoryGirl.create(:reservation, user: @user)
      r_1 =  FactoryGirl.create(:reservation, user: @other)

      expect(r_0.affinity(r_1)).to be 1.0
      expect(r_1.affinity(r_0)).to be 1.0
    end

    it "with diffent plan" do
      r_0 =  FactoryGirl.create(:reservation, user: @user, after_plan: true)
      r_1 =  FactoryGirl.create(:reservation, user: @other, after_plan: false)

      expect(r_0.affinity(r_1)).to be 0.5
      expect(r_1.affinity(r_0)).to be 0.5
    end
  end

  describe "#table affinity?" do
    it "computes" do
      table =  FactoryGirl.create(:table)
      FactoryGirl.create(:reservation, user: @user, table: table)
      FactoryGirl.create(:reservation, user: @other, table: table)
      expect(table.affinity).to be 85
    end
  end

  describe "example affinity?" do
    def create_test *values
      FactoryGirl.create(:test, 
                extraversion: values[0],
                educacion: values[1], 
                freakismo: values[2],
                hipsterismo: values[3])
    end

    def answer_test user, test, answer
      if answer == :A
        answer =  test.caption_A
      else
        answer =  test.caption_B
      end
      TestResponse.create(user: user, 
                          test: test, 
                          response: answer)
    end


    it "works" do
      test_0 = create_test(2, -2, 1, -1)
      test_1 = create_test(1, -2, 0, -1)
      answer_test(@user, test_0, :A)
      answer_test(@other, test_0, :B)
     
      print "AFFINITY: ", @user.affinity(@other)

    end
  end
  
end