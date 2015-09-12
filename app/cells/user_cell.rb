class UserCell < BaseCell



  def default_card
    "**** **** **** #{model.default_card}" if !model.default_card.nil?
  end

  def logout_link
    if user_signed_in?
      @path = auth_logout_path
      render
    end
  end

  def my_reservations_link
    if user_signed_in?
      @path = user_reservations_path(model)
      render
    end
  end

  def notifications_link
    if user_signed_in?
      @path = user_notifications_path(model)
      render
    end
  end

  def new_reservation_link
    if user_signed_in?
      @path = new_user_reservation_path(model)
      render
    end
  end

  def show_link
    if admin_signed_in?
      @path = admin_user_path(model)
      render
    elsif restaurant_signed_in?
      @path = restaurant_user_path(current_restaurant, model)
      render
    elsif model.is_owned_by?(current_user)
      @path = user_path(model)
      render
    end
  end

  def edit_link
    if admin_signed_in?
      @path = edit_admin_user_path(model)
      render
    elsif model.is_owned_by?(current_user)
      @path = edit_user_path(model)
      render
    end
  end

  def test_link
    if model.is_owned_by?(current_user)
      @path = user_test_path(model)
      render
    end
  end

  def last_minute_diinners_link
    if model.is_owned_by?(current_user)
      @path = user_last_minute_diinners_path(model)
      render
    end
  end

  def age_preference
    "#{model.min_age}...#{model.max_age}" if !model.preference.nil?
  end

  def city_preference
    model.city.name if !model.city.nil?
  end

  def menu_preference
    model.menu_price

  end

  def after_plan_preference
    model.after_plan ? "Go for drinks" : "Go to sleep"  
  end
end