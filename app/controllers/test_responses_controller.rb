class  TestResponsesController < UsersController
  load_resource :user
  load_resource :test, :only => [:create]

  def new
    @test = @user.test_pending.sample
    # TODO do not redirect, add fallback screen
    redirect_to user_path(@user) unless @test
  end

  def create
    response = @user.test_completed.create!(test: @test, response: params[:option])
    response.notify "create"
    redirect_to user_test_path(@user), :notice => 'Test was successfully sent.'
  end

end