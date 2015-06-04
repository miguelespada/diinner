
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    # Using metaprogramming to send to class paths
    send("#{resource.model_name.param_key}_path", resource.id)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def check_authorization! user, resource
    raise CanCan::AccessDenied.new("Not authorized!") if !resource.is_owned_by?(user)
  end

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
  end
end