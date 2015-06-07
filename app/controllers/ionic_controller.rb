# This controller is for development pourposes

class IonicController < ActionController::Base
  before_action :load_user

  def user
    render json: @user
  end

  def notifications
    render json: @user.notifications
  end

  private
    def load_user
      @user = User.desc(:updated_at).first
    end
end
