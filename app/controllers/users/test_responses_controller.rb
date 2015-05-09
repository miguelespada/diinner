class  Users::TestResponsesController < UsersController

  def new
    # TODO: maybe @user to before filter
    @user = @session.user_from_session
    @test = TestSelector.get_random_test(@user)
    redirect_to user_path(@user) unless @test
    @test_response = TestResponse.new
  end

  def create
    @test_response = TestResponse.new(test_response_params)
    @test_response.user = @session.user_from_session
    @test_response.save!
    redirect_to users_test_path, :notice => 'Test was successfully sent.'
  end


  private

  def test_response_params
    params.require(:test_response).permit(:response, :test)
  end

end