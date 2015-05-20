class BaseCell < Cell::ViewModel
  include Devise::Controllers::Helpers
  helper_method :admin_signed_in?, :restaurant_signed_in?, :current_restaurant
 
  private

  def restaurant
    cell(:restaurant, model.restaurant)
  end


  def method_missing(m, *args, &block) 
    render m
  end  

  def current_user
    # TODO not very dry but no workaround
    UserSession.new(session).user_from_session
  rescue
    nil
  end

  def user_signed_in?
    !current_user.nil?
  end

end