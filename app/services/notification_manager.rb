class NotificationManager

  # I'll follow the method name convention who_action_object

  def self.notify_admin_create_restaurant (from: Admin.first, object: nil, to: Admin.first)
    object.create_activity key: 'restaurant.create', owner: from, recipient: to
  end
end