
class ReservationCell < BaseCell

  property :price
  property :status
  property :date
  property :locator

  def hour
    cell(:table, model.table).hour
  end

  def after_plan
    model.go_for_drinks? ? "Go for drinks" : "Go to sleep"  
  end
  
  def total_amount
    model.charge_amount / 100
  end


  def status
    model.status.capitalize
  end

  def user
    cell(:user, model.user)
  end

  def evaluation
    cell(:evaluation, model.evaluation)
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
    p model.paid?
    if model.is_owned_by?(current_restaurant) && model.paid?
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
    if model.is_owned_by?(current_user) && model.can_be_cancelled?
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