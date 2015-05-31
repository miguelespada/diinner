module ReservationStatus
  extend ActiveSupport::Concern

  included do

    def pending?
      customer.present? && !paid? && !cancelled?
    end

    def payment_reserved?
      charge_id != nil && pending?
    end

    def cancelled?
      cancelled || paymement_error?
    end

    def status
      return :cancelled if cancelled?
      return :confirmed if paid?
      return :pending if pending?
      return :new
    end

  end
end