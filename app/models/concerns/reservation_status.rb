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
      return :cancelled if cancelled?
      return :error if payment_error?
      return :paid if paid?
      return :payment_reserved if payment_reserved?
      return :confirmed if confirmed?
      return :pending
    end

  end
end