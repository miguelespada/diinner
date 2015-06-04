class Auth0Controller < ApplicationController
  def callback
    session[:userinfo] = request.env['omniauth.auth']
    redirect_to users_path
  end

  def failure
    @error_msg = request.params['message']
  end

  def logout
    session.delete(:userinfo)
    redirect_to root_path
  end
end
