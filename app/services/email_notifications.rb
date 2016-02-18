module EmailNotifications

  def self.notify to, subject
    Pony.mail(:to => to,
              :from => "noreply@diinner.com",
              :subject => "[Diinner] #{subject}")
    
  end

  def self.notify_new_reservation to, user, restaurant
    return if Rails.env.test?

    Pony.mail(:to => to,
              :from => "noreply@diinner.com",
              :subject => "[Diinner] New reservation for restaurant #{restaurant.name} by #{user.name}")
  end

  def self.notify_plan_confirmation reservation
    return if Rails.env.test?
    restaurant = reservation.restaurant
    user = reservation.user

    Pony.mail(:to => user.email,
              :from => "noreply@diinner.com",
              :subject => "[Diinner] Tu reserva para hoy en el #{restaurant.name} está confirmada!")
  end

  def self.notify_plan_cancellation reservation
    return if Rails.env.test?
    restaurant = reservation.restaurant
    user = reservation.user

    Pony.mail(:to => user.email,
              :from => "noreply@diinner.com",
              :subject => "[Diinner] Lo sentimos tu reserva hoy el #{restaurant.name} ha sido cancelada :(")
  end

  def self.invite_to_evaluate reservation
    return if Rails.env.test?
    restaurant = reservation.restaurant
    user = reservation.user

    Pony.mail(:to => user.email,
              :from => "noreply@diinner.com",
              :subject => "[Diinner] Cuéntanos qué tal te lo pasaste")
  end

  def seld.notify_table_confirmation table
    return if Rails.env.test?
    restaurant = table.restaurant

    Pony.mail(:to => restaurant.email,
              :from => "noreply@diinner.com",
              :subject => "[Diinner] Tienes una reserva para esta noche!")

  end

  def seld.notify_table_full table
    return if Rails.env.test?
    restaurant = table.restaurant

    Pony.mail(:to => restaurant.email,
              :from => "noreply@diinner.com",
              :subject => "[Diinner] Tenemos nuevos comensales para la reserva de esta noche")

  end

end