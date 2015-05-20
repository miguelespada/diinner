class ReservationCell < BaseCell
  def details
    render
  end

  def status
    model.status.capitalize
  end
  
  def user
    cell(:user, model.user)
  end

  def menu
    cell(:menu, model.assigned_menu)
  end

  def table
    cell(:table, model.table)
  end

  def row
    if admin_signed_in?
      render :admin_row
    elsif model.is_owned_by?(current_restaurant)
      render :restaurant_row
    end
  end

  def show_link
    if admin_signed_in?
      @path = admin_reservation_path(model)
      render
    end
  end

  def reserve_link
    if model.is_owned_by?(current_user)
      @path = user_reservations_path(current_user, :reservation => model.attributes)
      render
    end
  end
end