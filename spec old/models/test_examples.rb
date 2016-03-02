require "rails_helper" 
describe User do

  before(:each) do 
    @user = FactoryGirl.create(:user)
    @other = FactoryGirl.create(:user)
  end

  def create_test *values
    FactoryGirl.create(:test, 
              expectativas: values[0],
              cultura: values[1], 
              foodie: values[2],
              frikismo: values[3],
              estudios: values[4],
              belleza: values[5],
              humor: values[6]
              )
  end

  def answer_test user, test, answer
    answer = answer == :A ? test.caption_A : test.caption_B

    TestResponse.create(user: user, 
                        test: test, 
                        response: answer)
  end


  describe "example affinity?" do
    it "works" do
      # test = create_test(2, -2, 1, -1, 2, 1, -2)
      # test = create_test(1, -2, 0, -1, 2, 1, -2)
      test = create_test(0, 0, 0, 0, 0, 0, 1)

      answer_test(@user, test, :A)
      answer_test(@other, test, :B)
      # answer_test(@user, test_1, :A)
      # answer_test(@other, test_1, :A)
      print "AFFINITY: ", @user.affinity(@other)
    end
  end
  
end