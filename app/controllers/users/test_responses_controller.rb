class  Users::TestResponsesController < BaseUsersController
  load_resource :test, :only => [:create]

  def new
    @test = @user.test_pending.sample
    if @test
      render
    else
      redirect_to user_path(@user), :notice => t("all_tests_completed")
    end
  end

  def create
    response = @user.test_completed.create!(test: @test, response: params[:option])
    NotificationManager.notify_user_create_test_response object: response, from: @user
    Rails.cache.delete("test_completed_" + self.id.to_s)

    if response.skipped?
      redirect_to :back
    else
      redirect_to :back, notice: t("test_completed")
    end
  end

end