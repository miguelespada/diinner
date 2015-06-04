# This controller is for development pourposes

class IonicController < ApplicationController
  respond_to :json
  before_action :load_user

  def users
    respond_with [@user]
  end

  private
    def load_user
      @user = User.desc(:updated_at).first
    end
end