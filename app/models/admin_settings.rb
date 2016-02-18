class AdminSettings
  include Mongoid::Document

  field :protected_mode,   type: Boolean
  field :map_box, type: String

  after_save :flush_cache

  def flush_cache
    Rails.cache.delete("admin_settings")
  end

  def self.is_protected?
    Rails.cache.fetch("admin_settings", expires_in: 1.day) do 
      self.get_first.protected_mode
    end
  end

  def self.get_first
    AdminSettings.first || AdminSettings.create
  end

  def self.permitted_parameters
    [:protected_mode, :map_box]
  end
end