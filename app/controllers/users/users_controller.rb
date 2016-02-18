class Users::UsersController < BaseUsersController

  def login
    render layout: 'login'
  end

  def drop_out
    @current_user.drop_out
    @current_user.save
    redirect_to drop_out_path
  end

  def edit
    @current_user.preference ||= Preference.new
  end

  def show
    @test = @user.sample_test
    @future_reservations = @user.cached_future_reservations.take(3)
    @eval_reservations = @user.cached_to_evaluate_reservations.take(3)
    @blog_posts = BlogPost.cached_posts
    # TODO suggestions are very slow! 
    # @user.suggestions if !@user.busy?(Date.tomorrow)
    @suggestions = [] 

  end

  def update
    @current_user.drop_in
    if @current_user.update!(user_params)
      redirect_to user_path(@current_user), notice: t("profile_updated")
    else
      render :edit
    end
  rescue => e
    flash[:notice] = @current_user.errors.first[1]
    render :edit
  end

  def delete_activity
    @user.notifications.find(params[:activity_id]).destroy!
    redirect_to :back, notice: 'Activity were successfully destroyed.'
  end

  private

  def user_params
    params.require(:user).permit(:gender,
                                  :birth,
                                  :preference_attributes => [:max_age, :min_age, :after_plan,
                                                             :city_id, :menu_range, :use_photo_for_compatibility, :id])
  end

end