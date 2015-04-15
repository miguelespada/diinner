class RestaurantCell < Cell::ViewModel
  def row
    render
  end

  def dropdown_menu
    render
  end

  private
  def delete_link
    render
  end

  def status
    "Inactive"
  end

  private
  def logout_link
    render
  end
end
