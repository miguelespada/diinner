class MenuCell < BaseCell

  def delete_link
    if model.is_owned_by?(current_restaurant)
      @path = restaurant_menu_path(model.restaurant, model)
      render
    end
  end

  def new_link
    if restaurant_signed_in?
      @path = new_restaurant_menu_path(current_restaurant)
      render
    end
  end

  def show_link
    return if model == :undefined
    if admin_signed_in?
      @path = admin_menu_path(model)
      render
    else
      @path = restaurant_menu_path(model.restaurant, model)
      render
    end
  end

  def edit_link
    if model.is_owned_by?(current_restaurant)
      @path = edit_restaurant_menu_path(model.restaurant, model)
      render
    end
  end
end