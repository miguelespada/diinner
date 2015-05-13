class MenuCell < BaseCell

  def delete_link
    @path = restaurant_menu_path(current_restaurant, model)
    render
  end

  def new_link
    @path = new_restaurant_menu_path(current_restaurant)
    render
  end

  def show_link
    @path = restaurant_menu_path(current_restaurant, model)
    render
  end

  def edit_link
    @path = edit_restaurant_menu_path(current_restaurant, model)
    render unless @path.nil?
  end
end