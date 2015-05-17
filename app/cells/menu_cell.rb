class MenuCell < BaseCell

  def delete_link
    @path = restaurant_menu_path(model.restaurant, model)
    render
  end

  def new_link
    @path = new_restaurant_menu_path(current_restaurant)
    render
  end

  def show_link
    if admin_signed_in?
      @path = admin_menu_path(model)
    else
      @path = restaurant_menu_path(model.restaurant, model)
    end

    render unless @path.nil?
  end

  def edit_link
    @path = edit_restaurant_menu_path(model.restaurant, model)
    render unless @path.nil?
  end
end