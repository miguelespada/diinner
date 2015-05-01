class BaseCell < Cell::ViewModel
  include Devise::Controllers::Helpers
  helper_method :admin_signed_in?, :restaurant_signed_in?
  
  private
  def method_missing(m, *args, &block)  
    render m
  end  
end