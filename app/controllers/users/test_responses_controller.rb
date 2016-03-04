class  Users::TestResponsesController < BaseUsersController
  load_resource :test, :only => [:create]

  def new
    @test = @user.sample_test
    redirect_to user_path(@user), :notice => t("all_tests_completed") unless @test
  end

  def create
    response = @user.test_completed.create!(test: @test, response: params[:option])
    
    NotificationManager.notify_user_create_test_response object: response, from: @user

    @user.process_new_test_response(response)

    redirect_to :back
  end

end