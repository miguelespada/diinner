class Auth0Controller < ApplicationController
  def callback
    # This stores all the user information that came from Auth0
    # and the IdP
    session[:userinfo] = request.env['omniauth.auth']

    # Redirect to the URL you want after successfull auth
    redirect_to users_show_path
  end

  def failure
    # show a failure page or redirect to an error page
    @error_msg = request.params['message']
  end

  def logout
    session.delete(:userinfo)
    #logout from auth0
    redirect_to "https://rodcrespo.eu.auth0.com/v2/logout?returnTo=" + request.base_url
  end
end
