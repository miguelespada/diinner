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
    redirect_to edit_user_path(@current_user) if @current_user.first_login?
    
    @test = @user.sample_test

    rvs = @user.reservations.includes(:table).where(cancelled: false).asc('date')

    @future_reservations = rvs.where(:date.gte => Date.today).limit(3).to_a
    @eval_reservations = rvs.where(paid: true, :date.lte => Date.today).select{|r| r.can_be_evaluated?}.take(3)

    params = {price: @user.menu_range, city: @user.city, after_plan: @user.after_plan, date: Date.tomorrow.strftime("%d/%m/%Y"), companies_attributes: []}
    suggestionEngine = SuggestionEngine.new @user, params
    @suggestions = suggestionEngine.search.first(3) unless @user.busy?(suggestionEngine.date)
    @blog_posts = BlogPost.cached_posts
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