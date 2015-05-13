class  TestResponsesController < UsersController

  before_action :load_user

  def new
    @test = @user.test_pending.sample
    redirect_to user_path(@user) unless @test
  end

  def create
    TestResponse.create!(user: @user,
                    test: Test.find(params[:test_id]),
                    response: params[:option]
                    )
    
    redirect_to user_test_path(@user), :notice => 'Test was successfully sent.'
  end

  private

  def load_user
    @user = User.find(params[:user_id])
  end

end