
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    # TODO I don't like this way (but cannot find alternative)

    if resource.class.name == "Restaurant"
      restaurant_calendar_path(resource)
    else
      send("#{resource.model_name.param_key}_path", resource.id)
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
  end

end