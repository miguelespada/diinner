module EmailNotifications

  def self.notify to, subject
    Pony.mail(:to => to,
              :from => "noreply@diinner.com",
              :subject => "[Diinner] #{subject}") if Rails.env.test?
    
  end

  def self.notify_new_user
    Pony.mail(:to => "jose@diinner.com",
              :from => "noreply@diinner.com",
              :subject => "[Diinner] Nuevo usuari@!!!") if Rails.env.test?
    
  end

  def self.notify_new_reservation to, user, restaurant
    Pony.mail(:to => to,
              :from => "noreply@diinner.com",
              :subject => "[Diinner] New reservation for restaurant #{restaurant.name} by #{user.name}") if Rails.env.test?
  end


  def self.notify_cancel_reservation reservation
    restaurant = reservation.restaurant
    user = reservation.user

    Pony.mail(:to => user.email,
              :from => "noreply@diinner.com",
              :subject => "[Diinner] la reserva para el #{restaurant.name} ha sido cancelada ") if Rails.env.test?
  end

  def self.notify_plan_confirmation reservation
    restaurant = reservation.restaurant
    user = reservation.user
    Pony.mail(:to => user.email,
              :from => "noreply@diinner.com",
              :subject => "[Diinner] Tu reserva para hoy en el #{restaurant.name} está confirmada!") if Rails.env.test?
  end

  def self.notify_plan_cancellation reservation
    restaurant = reservation.restaurant
    user = reservation.user

    Pony.mail(:to => user.email,
              :from => "noreply@diinner.com",
              :subject => "[Diinner] Lo sentimos tu reserva hoy el #{restaurant.name} ha sido cancelada :(") if Rails.env.test?
  end

  def self.invite_to_evaluate reservation
    restaurant = reservation.restaurant
    user = reservation.user

    Pony.mail(:to => user.email,
              :from => "noreply@diinner.com",
              :subject => "[Diinner] Cuéntanos qué tal te lo pasaste") if Rails.env.test?
  end

  def self.notify_table_confirmation table
    return if Rails.env.test?
    restaurant = table.restaurant

    Pony.mail(:to => restaurant.email,
              :from => "noreply@diinner.com",
              :subject => "[Diinner] Tienes una reserva para esta noche!") if Rails.env.test?

  end

  def self.notify_table_full table
    restaurant = table.restaurant

    Pony.mail(:to => restaurant.email,
              :from => "noreply@diinner.com",
              :subject => "[Diinner] Tenemos nuevos comensales para la reserva de esta noche") if Rails.env.test?

  end

end