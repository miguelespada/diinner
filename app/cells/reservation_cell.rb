
class ReservationCell < BaseCell

  property :price
  property :status
  property :date

  def hour
    cell(:table, model.table).hour
  end

  def status
    model.status.capitalize
  end

  def user
    cell(:user, model.user)
  end

  def payment
    cell(:payment, model.payment) if !model.payment.nil?
  end

  def menu
    cell(:menu, model.menu)
  end

  def table
    cell(:table, model.table)
  end

  def validate_link
    # TODO Only validate when paid!
    if model.is_owned_by?(current_restaurant) && !model.cancelled?
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
    elsif model.is_owned_by?(current_user)
      @path = user_reservation_path(current_user, model)
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
    # TODO if is not today
    if model.is_owned_by?(current_user) && !model.cancelled?
      @path = user_reservation_cancel_path(current_user, model)
      render
    end
  end

  def evaluate_link
    if model.is_owned_by?(current_user) && model.can_be_evaluated?
      @path = new_user_reservation_evaluation_path(current_user, model)
      render
    end
  end
end