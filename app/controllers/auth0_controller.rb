class Auth0Controller < ApplicationController
  def callback
    p request.env['omniauth.auth']
    session[:userinfo] = request.env['omniauth.auth']
    redirect_to users_path
  end

  def failure
    @error_msg = request.params['message']
    redirect_to root_path, alert: @error_msg
  end

  def logout
    session.delete(:userinfo)
    redirect_to root_path
  end
end
