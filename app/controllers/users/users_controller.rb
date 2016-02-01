class Users::UsersController < BaseUsersController

  def login
    render layout: 'login'
  end

  def edit
    @current_user.preference ||= Preference.new
  end

  def show
    redirect_to edit_user_path(@current_user) if @current_user.first_login?
    @test = @user.test_pending.sample
    @reservations = @user.reservations.where(cancelled: false).limit(3)
    params = {price: @user.menu_range, city: @user.city, after_plan: @user.after_plan, date: Date.tomorrow.strftime("%d/%m/%Y"), companies_attributes: []}
    suggestionEngine = SuggestionEngine.new @user, params
    @suggestions = suggestionEngine.search.first(3)
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