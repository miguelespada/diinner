class TableCell < BaseCell
  include ActionView::Helpers::DateHelper

  def delete_link
    @path = restaurant_table_path(current_restaurant, model)
    render
  end

  def new_link
    @path = new_restaurant_table_path(current_restaurant)
    render
  end

  def show_link
    @path = restaurant_table_path(current_restaurant, model)
    render
  end

  def edit_link
    @path = edit_restaurant_table_path(current_restaurant, model)
    render unless @path.nil?
  end
end