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
      user.create_activity key: 'user.create', owner: user
    else
      user.update(hash_from_omniauth)
    end
    user
  end

  def user_from_session_ionic #TODO Check if best way
    user = find_user_ionic
    if user.nil?
      user = User.new(hash_from_omniauth_ionic)
      user.save
      user.create_activity key: 'user.create', owner: user
    else
      user.update(hash_from_omniauth_ionic)
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

  def hash_from_omniauth_ionic #TODO Check if best way
    logged_user_info = @session
    {
        email: logged_user_info[:email],
        image_url: logged_user_info[:picture],
        name: logged_user_info[:name]
    }
  end

  def find_user_ionic #TODO Check if best way
    User.where(email: @session[:email]).first
  end
end