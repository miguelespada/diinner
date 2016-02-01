class StaticController < ApplicationController

  layout "home", except: :help
  before_action :create_session, only: :help

  def index
  end

  def help
    render 'static/help', layout: @session.logged? ? 'user' : 'home'
  end

  private
  def create_session
    @session ||= UserSession.new(session)
  end

end