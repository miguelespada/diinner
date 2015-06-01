class PaymentCell < BaseCell
  def reservation
    cell(:reservation, model.reservation)
  end

   def show_link
    if admin_signed_in?
      @path = admin_payment_path(model)
      render
    end
  end
end