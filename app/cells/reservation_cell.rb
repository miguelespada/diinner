class ReservationCell < BaseCell
  def reserve_link
    if model.is_owned_by?(current_user)
      @path = user_reservations_path(current_user, :reservation => model.attributes)
      render
    end
  end
end