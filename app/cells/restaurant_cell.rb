class RestaurantCell < Cell::ViewModel
  def row
    render
  end

  private
  
  def render_destroy_link
    link_to "Delete",  admin_restaurant_path(model), method: :delete, data: { confirm: 'Are you sure?' }
  end

end
