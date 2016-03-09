module EmailNotifications

  def self.notify(mail_params)
    return if Rails.env.test?
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
                    params: {
                    }
    })
  end

  def self.notify_process_tables table_count, type
    self.notify({
                    to: "jose@diinner.com",
                    from: "noreply@diinner.com",
                    subject: "[Diinner] Procesando mesas (#{type})",
                    view: "mail/process",
                    params: {
                        table_count: table_count
                    }
                })
  end

  def self.notify_new_reservation reservation
    restaurant = reservation.restaurant
    user = reservation.user
    self.notify({
                    to: user.email,
                    from: "noreply@diinner.com",
                    subject: "Diinner: nueva reserva en #{restaurant.name} para el #{reservation.date.to_s.first(10)}",
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
                    subject: "Diinner: confirmación de cancelación de reserva en #{restaurant.name} para el #{reservation.date.to_s.first(10)}",
                    view: "mail/cancel_reservation",
                    params: {
                        user: user,
                        restaurant: restaurant,
                        reservation: reservation
                    }
                })
  end

  def self.notify_plan_confirmation reservation
    restaurant = reservation.restaurant
    user = reservation.user
    self.notify({
                    to: user.email,
                    from: "noreply@diinner.com",
                    subject: "Diinner: ¡plan para hoy en #{restaurant.name} confirmado!",
                    view: "mail/plan_confirmation",
                    params: {
                        user: user,
                        restaurant: restaurant,
                        reservation: reservation
                    }
                })
  end

  def self.notify_plan_cancellation reservation
    restaurant = reservation.restaurant
    user = reservation.user
    self.notify({
                    to: user.email,
                    from: "noreply@diinner.com",
                    subject: "Diinner: se ha cancelado el plan de hoy en #{restaurant.name} :(",
                    view: "mail/plan_cancellation",
                    params: {
                        user: user,
                        restaurant: restaurant,
                        reservation: reservation
                    }
                })
    #TODO 2-3 cancellation
  end

  def self.invite_to_evaluate reservation
    restaurant = reservation.restaurant
    user = reservation.user
    self.notify({
                    to: user.email,
                    from: "noreply@diinner.com",
                    subject: "Diinner: cuéntanos qué tal te lo pasaste",
                    view: "mail/evaluation",
                    params: {
                        user: user,
                        restaurant: restaurant,
                        reservation: reservation
                    }
                })
  end

  def self.notify_table_confirmation table
    restaurant = table.restaurant
    self.notify({
                    to: restaurant.email,
                    from: "noreply@diinner.com",
                    subject: "[Diinner] Reserva confirmada para esta noche",
                    view: "mail/table_confirmation",
                    params: {
                        table: table,
                        restaurant: restaurant
                    }
                })

  end

  def self.notify_table_full table
    restaurant = table.restaurant
    self.notify({
                    to: restaurant.email,
                    from: "noreply@diinner.com",
                    subject: "[Diinner] Nuevos comensales para una mesa de esta noche",
                    view: "mail/table_full",
                    params: {
                        table: table,
                        restaurant: restaurant
                    }
                })
  end

end