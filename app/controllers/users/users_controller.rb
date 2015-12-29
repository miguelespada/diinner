class Users::UsersController < BaseUsersController

  def login
    render :layout => false
  end

  def edit
    @current_user.preference ||= Preference.new
  end

  def show
    redirect_to edit_user_path(@current_user) if @current_user.first_login?
    @reservations = @user.reservations.where(cancelled: false)
  end

  def update
    if @current_user.update(user_params)
      redirect_to user_path(@current_user), notice: 'Your profile was successfully updated.'
    else
      render :edit
    end
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
                                                             :city_id, :menu_range, :id])
  end

end