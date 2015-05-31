module ReservationPayment
  extend ActiveSupport::Concern

  included do

    def charge_amount
      price * (male_count + female_count) * 100
    end

    def create_stripe_charge
      Stripe::Charge.create({
          :amount   => charge_amount,
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
      ).id
      rescue => e
        false
    end

    def capture
      payment_id = create_stripe_charge
      if payment_id
        self.update(charge_id: payment_id)
        true
      else
        self.update(payment_error: true)
        false
      end
    end

    def stripe_capture
      begin
        ch = Stripe::Charge.retrieve(self.charge_id)
        ch.capture
        true
      rescue => e
        false
      end
    end

    def charge
      return false if !payment_reserved?
      if stripe_capture
        self.update(paid: true)
      else
        self.update(payment_error: true)
      end
    end

    def refund
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
