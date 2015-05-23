class UserCell < BaseCell

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

end