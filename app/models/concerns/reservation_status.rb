module ReservationStatus
  extend ActiveSupport::Concern

  included do

    field :cancelled, type: Boolean, default: false
    field :paid, type: Boolean, default: false
    field :charge_id, type: String
    field :ticket_valid, type: Boolean, default: false
    field :payment_error, type: Boolean, default: false

    def can_be_cancelled?
      pending? && !is_last_minute?
    end

    def closes_last_minute_plan?
      is_last_minute? && table.full?
    end

    def passed?
      Date.today > date
    end

    def can_be_evaluated?
      passed? && paid? && !evaluated?
    end

    def evaluated?
      !evaluation.nil?
    end

    def pending?
      customer.present? && !paid? && !cancelled?
    end

    def payment_reserved?
      charge_id != nil && pending?
    end

    def cancelled?
      cancelled || payment_error
    end

    def status
      return :cancelled if cancelled?
      return :validated if ticket_valid?
      return :confirmed if paid?
      return :pending if pending?
      return :new
    end

  end
end