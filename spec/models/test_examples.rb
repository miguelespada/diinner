require "rails_helper" 
describe User do

  before(:each) do 
    @user = FactoryGirl.create(:user)
    @other = FactoryGirl.create(:user)
  end

  def create_test *values
    FactoryGirl.create(:test, 
              extraversion: values[0],
              educacion: values[1], 
              freakismo: values[2],
              hipsterismo: values[3])
  end

  def answer_test user, test, answer
    answer = answer == :A ? test.caption_A : test.caption_B

    TestResponse.create(user: user, 
                        test: test, 
                        response: answer)
  end


  describe "example affinity?" do
    it "works" do
      test_0 = create_test(2, -2, 1, -1)
      test_1 = create_test(1, -2, 0, -1)

      answer_test(@user, test_0, :A)
      answer_test(@other, test_0, :B)
      answer_test(@user, test_1, :A)
      answer_test(@other, test_1, :A)

      print "AFFINITY: ", @user.affinity(@other)
    end
  end
  
end