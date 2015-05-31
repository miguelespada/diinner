class ReservationCell < BaseCell

  def hour
    cell(:table, model.table).hour
  end

  def status
    model.status.capitalize
  end

  def user
    cell(:user, model.user)
  end

  def menu
    cell(:menu, model.menu)
  end

  def table
    cell(:table, model.table)
  end

  def restaurant_link
    link_to model.restaurant.name, user_reservation_restaurant_path(current_user, model)
  end

  def menu_link
    link_to model.menu.name, user_reservation_menu_path(current_user, model)
  end

   def validate_link
    if model.is_owned_by?(current_restaurant)
      if !model.ticket_valid?
        link_to "validate", restaurant_reservation_validate_path(current_restaurant, model, :ticket_valid => true)
      else
        link_to "unvalidate", restaurant_reservation_validate_path(current_restaurant, model, :ticket_valid => false)
      end
    end
  end

  def occupied_slots
    "#{model.male_count}/#{model.female_count}"
  end

  def show_link
    if admin_signed_in?
      @path = admin_reservation_path(model)
      render
    elsif model.is_owned_by?(current_restaurant)
      @path = restaurant_reservation_path(model.restaurant, model)
      render
    end
  end

  def reserve_link
    if model.is_owned_by?(current_user)
      @path = user_reservations_path(current_user, :reservation => model.as_json)
      render
    end
  end

   def cancel_link
    if model.is_owned_by?(current_user)
      @path = user_reservation_cancel_path(current_user, model)
      render
    end
  end
end