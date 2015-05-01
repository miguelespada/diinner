class RestaurantCell < BaseCell
  include ActionView::Helpers::DateHelper
  def delete_link
    @path = admin_restaurant_path(model)
    render
  end

  def new_link
    @path = new_admin_restaurant_path
    render
  end

  def show_link
    if admin_signed_in?
      @path = admin_restaurant_path(model)
    else
      @path = restaurant_path(model)
    end
    render
  end
  
  def edit_link
    if admin_signed_in?
      @path = edit_admin_restaurant_path(model)
    elsif restaurant_signed_in?
      # TODO: test authorization
      @path = edit_restaurant_path(model)
    end
    # TODO: test that a user do not see the edit link
    render unless @path.nil?
  end

  def logout_link
    @path = destroy_restaurant_session_path
    render
  end

  private
  
  def status
    "Last time active: " + (@model.current_sign_in_at.nil? ? "never" : time_ago_in_words( @model.current_sign_in_at )).to_s
  end
end