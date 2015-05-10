class BaseCell < Cell::ViewModel
  include Devise::Controllers::Helpers
  helper_method :admin_signed_in?, :restaurant_signed_in?, :current_restaurant

  private
  def method_missing(m, *args, &block) 
    set_current_user_from_arg args
    render m
  end  

  def set_current_user_from_arg args
    @@current_user = args[0][:current_user] if !args[0].nil? && !args[0][:current_user].nil?
  end 
end