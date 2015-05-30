module ReservationPayment
  extend ActiveSupport::Concern

  included do

    def capture
      begin
        payment_data = Stripe::Charge.create({
            :amount   => price * user_count * 100,
            :currency => "eur",
            :customer => customer,
            :capture => false,
            :metadata => {
              'reservation_id' => self.id,
              'user' => user.email,
              'restaurant' => self.restaurant.name}
          },
          {
            :idempotency_key => self.id
          }
        )
        self.update(charge_id: payment_data.id)
      rescue => e
        self.update(payment_error: true)
        e
      end
    end

    def charge
      return false if !payment_reserved?
      begin
        ch = Stripe::Charge.retrieve(self.charge_id)
        capture_date = ch.capture
        self.update(paid: true)
      rescue => e
        self.update(payment_error: true)
        e
      end
    end

    def refund
      return false if !payment_reserved?
      begin
        ch = Stripe::Charge.retrieve(self.charge_id)
        refund = ch.refund
        self.update(charge_id: nil)
      rescue => e
        self.update(payment_error: true)
        e
      end
    end

  end
end
