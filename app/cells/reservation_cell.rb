class ReservationCell < BaseCell
  def details
    render
  end
  def status
    model.status.capitalize
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