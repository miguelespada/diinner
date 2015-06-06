class  Users::TestResponsesController < BaseUsersController
  load_resource :test, :only => [:create]

  def new
    @test = @user.test_pending.sample
    if @test
      render
    else
      redirect_to user_path(@user), :notice => 'You have completed all the tests.'
    end
  end

  def create
    response = @user.test_completed.create!(test: @test, response: params[:option])
    response.notify "create"
    redirect_to user_test_path(@user), :notice => 'Test was successfully sent.'
  end

end