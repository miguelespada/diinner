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
            'restaurant' => self.restaurant.name,
            'table' => self.table.id,
            'menu price' => self.price,
            'hour' => self.table.hour,
            'menu' => self.menu.name
            }
        },
        {
          :idempotency_key => self.id
        }
      ).id
      rescue
        false
    end

    def capture
      return true if paid?
      return false if cancelled?
      payment_id = create_stripe_charge
      if payment_id
        self.update(charge_id: payment_id)
      else
        self.update(payment_error: true)
      end
    end

    def stripe_capture
      Stripe::Charge.retrieve(self.charge_id).capture
      rescue
        false
    end

    def charge
      return true if paid?
      return false if !payment_reserved?
      data = stripe_capture
      if data
        self.update(paid: true)
        restaurant.payments.create(reservation: self, stripe_data: data.to_hash)
      else
        self.update(payment_error: true)
      end
    end

    def stripe_refund
      Stripe::Charge.retrieve(self.charge_id).refund
      rescue
        false
    end

    def refund
      return false if !payment_reserved?
      if stripe_refund
        self.update(charge_id: nil)
      else
        self.update(payment_error: true)
      end
    end

  end
end
