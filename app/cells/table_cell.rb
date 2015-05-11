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
    @path = restaurants_table_path(model)
    render
  end

  def edit_link
    @path = edit_restaurants_table_path(model)
    render unless @path.nil?
  end
end