class TableCell < BaseCell
  include ActionView::Helpers::DateHelper

  def delete_link
    @path = restaurants_table_path(model)
    render
  end

  def new_link
    @path = new_restaurants_table_path
    render
  end

  def show_link
    if admin_signed_in?
      @path = admin_table_path(model)
    else
      @path = restaurants_table_path(model)
    end
    render
  end

  def edit_link
    if model.is_owned_by?(current_restaurant)
      @path = edit_restaurants_table_path(model)
    end
    render unless @path.nil?
  end
end