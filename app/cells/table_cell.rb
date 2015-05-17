class TableCell < BaseCell
  include ActionView::Helpers::DateHelper

  def delete_link
    if restaurant_signed_in?
      @path = restaurant_table_path(current_restaurant, model)
      render
    end
  end

  def new_link
    if restaurant_signed_in?
      @path = new_restaurant_table_path(current_restaurant)
      render
    end
  end

  def show_link
    if user_signed_in?
      # TODO ???
      @path = user_restaurant_table_path(current_user, model.restaurant, model)
    elsif restaurant_signed_in?
      @path = restaurant_table_path(current_restaurant, model)
    else
      @path = admin_restaurant_table_path(model.restaurant, model)
    end
    render
  end

  def edit_link
    if restaurant_signed_in?
      @path = edit_restaurant_table_path(current_restaurant, model)
      render
    end
  end

  def reserve_link
    if user_signed_in?
      @path = user_restaurant_table_reserve_path(current_user, model.restaurant, model)
      render
    end
  end
end