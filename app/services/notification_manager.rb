class NotificationManager
  def self.notify_admin_create_restaurant(from: Admin.first, object: nil, to: Admin.first)
    object.create_activity key: 'restaurant.create', owner: from, recipient: to
  end

  def self.notify_user_creation(from: Admin.first, object: nil, to: Admin.first)
    object.create_activity key: 'user.create', owner: from, recipient: to
  end

  def self.notify_restaurant_create_menu(from: Admin.first, object: nil, to: Admin.first)
    object.create_activity key: 'menu.create', owner: from, recipient: to
  end

  def self.notify_user_create_test_response(from: Admin.first, object: nil, to: Admin.first)
    object.create_activity key: "TestResponse.create", owner: from, recipient: to
  end

  def self.notify_user_create_evaluation(from: Admin.first, object: nil, to: Admin.first)
    object.create_activity key: "evaluation.create", owner: from, recipient: to
  end

  def self.notify_restaurant_create_table(from: Admin.first, object: nil, to: Admin.first)
    object.create_activity key: "table.create", owner: from, recipient: to
  end

  def self.notify_comfirm_table(from: Admin.first, object: nil, to: Admin.first)
    key = "table.confirm"
    if to.notifications.where(trackable: object, key: key).count == 0  
      object.create_activity key: key, owner: from, recipient: to
    end
  end

  def self.notify_cancel_table(from: Admin.first, object: nil, to: Admin.first)
    key = "table.cancel"
    if to.notifications.where(trackable: object, key: key).count == 0 
      object.create_activity key: key, owner: from, recipient: to
    end
  end

  def self.notify_full_table(from: Admin.first, object: nil, to: Admin.first)
    object.create_activity key: "table.full", owner: from, recipient: to
  end

  def self.notify_cancel_plan(from: Admin.first, object: nil, to: Admin.first)
    key = "plan.cancel"
    if to.notifications.where(trackable: object, key: key).count == 0 
      object.create_activity key: key, owner: from, recipient: to
    end
  end

  def self.notify_confirm_plan(from: Admin.first, object: nil, to: Admin.first)
    key = "plan.confirm"
    if to.notifications.where(trackable: object, key: key).count == 0 
      object.create_activity key: key, owner: from, recipient: to
    end
  end

  def self.notify_user_create_reservation(object: nil)
    EmailNotifications.notify(Admin.first.email, "New reservation for restaurant #{object.restaurant.name}")
    object.create_activity key: "reservation.create", owner: object.user, recipient: object.restaurant
  end

  def self.notify_user_cancel_reservation(object: nil)
    object.create_activity key: "reservation.cancel", owner: object.user, recipient: object.restaurant
  end

  def self.notify_reservation_pending(object: nil)
    object.create_activity key: "reservation.pending", recipient: object.user, owner: object.restaurant
  end

  def self.notify_invitation_to_evaluate(from: Admin.first, object: nil, to: Admin.first)
    key = "reservation.evaluate"
    if to.notifications.where(trackable: object, key: key).count == 0 
      object.create_activity key: key, recipient: to, owner: from
    end
  end
end