class BaseCell < Cell::ViewModel
  include Devise::Controllers::Helpers
  include ActionView::Helpers::DateHelper
  include Rails::Timeago::Helper
  helper_method :admin_signed_in?, :restaurant_signed_in?, :current_restaurant

  def table title, head, collection
    @title = title
    @head = head
    @collection = collection
    render
  end

  def updated_timeago
    timeago_tag model.updated_at, :nojs => true, :limit => 10.days.ago if !model.nil?
  end

  private

  def restaurant
    cell(:restaurant, model.restaurant)
  end

  def method_missing(m, *args, &block)
    render m
  end

  def current_user
    # TODO not very dry but no workaround
    UserSession.new(session).user_from_session
  rescue
    nil
  end

  def user_signed_in?
    !current_user.nil?
  end

end