class RestaurantCell < Cell::ViewModel
  private
  def status
    "Inactive"
  end

  def method_missing(m, *args, &block)  
    render m
  end  
end
