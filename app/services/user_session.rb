class UserSession

  def initialize session
    @session = session
  end

  def logged?
    @session[:userinfo].present?
  end

  def sign_out
    @session.delete(:userinfo) if logged?
  end

  def user_from_session
    user = find_user
    if user.nil?
      user = User.new(hash_from_omniauth)
      user.save
      NotificationManager.notify_user_creation object: user, from: user
      EmailNotifications.notify_new_user
    else
      user.update(hash_from_omniauth)
    end
    user
  end


  private

  def hash_from_omniauth
    logged_user_info = @session[:userinfo][:info]
    {
      email: logged_user_info[:email],
      image_url: logged_user_info[:image],
      name: logged_user_info[:name]
    }
  end

  def find_user
    User.where(email: @session[:userinfo][:info][:email]).first
  end

end