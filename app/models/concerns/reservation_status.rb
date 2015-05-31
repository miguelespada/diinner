module ReservationStatus
  extend ActiveSupport::Concern

  included do

    def pending?
      customer.present? && !paid? && !cancelled? &&  !payment_error?
    end

    def payment_reserved?
      charge_id != nil && !paid?
    end

    def status
      # TODO cancelled
      # TODO with error
      return :cancelled if cancelled?
      return :error if payment_error?
      return :confirmed if paid?
      return :pending if pending?
      return :new
    end

  end
end