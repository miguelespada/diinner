class AdminSettings
  include Mongoid::Document

  field :protected_mode,   type: Boolean


  def self.is_protected?
    self.get_first.protected_mode
  end

  def self.get_first
    AdminSettings.first || AdminSettings.create
  end


  def self.permitted_parameters
    [:protected_mode]
  end
end