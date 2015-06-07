class Restaurants::PaymentsController < BaseRestaurantsController

  def index
    @payments = @restaurant.payments
  end

end