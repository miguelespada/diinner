module EmailNotifications

  def self.notify(mail_params)
    ac = ActionController::Base.new
    Pony.mail(:to => mail_params[:to],
              :from => mail_params[:from],
              :subject => "#{mail_params[:subject]}",
              html_body: ac.render_to_string(mail_params[:view],
                                             locals: mail_params[:params],
                                             :layout => false)
    )
  end

  def self.notify_new_user
    self.notify({
                    to: "jose@diinner.com",
                    from: "noreply@diinner.com",
                    subject: "[Diinner] Nuevo usuari@!!!",
                    view: "mail/new_user",
                    params: {}
    })
  end

  def self.notify_new_reservation reservation
    restaurant = reservation.restaurant
    user = reservation.user
    self.notify({
                    to: user.email,
                    from: "noreply@diinner.com",
                    subject: "[Diinner] New reservation for restaurant #{restaurant.name} by #{user.name}",
                    view: "mail/new_reservation",
                    params: {
                        user: user,
                        restaurant: restaurant,
                        reservation: reservation
                    }
                })
  end


  def self.notify_cancel_reservation reservation
    restaurant = reservation.restaurant
    user = reservation.user
    self.notify({
                    to: user.email,
                    from: "noreply@diinner.com",
                    subject: "[Diinner] la reserva para el #{restaurant.name} ha sido cancelada",
                    view: "mail/cancel_reservation",
                    params: {}
                })
  end

  def self.notify_plan_confirmation reservation
    restaurant = reservation.restaurant
    user = reservation.user
    self.notify({
                    to: user.email,
                    from: "noreply@diinner.com",
                    subject: "[Diinner] Tu reserva para hoy en el #{restaurant.name} está confirmada!",
                    view: "mail/plan_confirmation",
                    params: {}
                })
  end

  def self.notify_plan_cancellation reservation
    restaurant = reservation.restaurant
    user = reservation.user
    self.notify({
                    to: user.email,
                    from: "noreply@diinner.com",
                    subject: "[Diinner] Lo sentimos tu reserva hoy el #{restaurant.name} ha sido cancelada :(",
                    view: "mail/plan_cancellation",
                    params: {}
                })
    #TODO 2-3 cancellation
  end

  def self.invite_to_evaluate reservation
    restaurant = reservation.restaurant
    user = reservation.user
    self.notify({
                    to: user.email,
                    from: "noreply@diinner.com",
                    subject: "[Diinner] Cuéntanos qué tal te lo pasaste",
                    view: "mail/evaluation",
                    params: {}
                })
  end

  def self.notify_table_confirmation table
    return if Rails.env.test?
    restaurant = table.restaurant
    self.notify({
                    to: restaurant.email,
                    from: "noreply@diinner.com",
                    subject: "[Diinner] Tienes una reserva para esta noche!",
                    view: "mail/table_confirmation",
                    params: {}
                })

  end

  def self.notify_table_full table
    restaurant = table.restaurant
    self.notify({
                    to: restaurant.email,
                    from: "noreply@diinner.com",
                    subject: "[Diinner] Tenemos nuevos comensales para la reserva de esta noche",
                    view: "mail/table_full",
                    params: {}
                })
  end

end