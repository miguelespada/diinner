class RestaurantCell < Cell::ViewModel
  def row
    render
  end

  private
  def delete_link
    render
  end

  def status
    "Inactive"
  end
end
