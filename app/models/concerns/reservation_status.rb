module ReservationStatus
  extend ActiveSupport::Concern

  included do

    def confirmed?
      !paid? && customer.present?
    end

    def payment_reserved?
      charge_id != nil && !paid?
    end

    def status
      # TODO cancelled
      # TODO with error
      return :paid if paid?
      return :confirmed if confirmed?
      return :pending
    end

  end
end