class TableCell < BaseCell
  
  def hour
    model.hour.strftime("%H:%M") if !model.hour.nil?
  end

  def delete_link
    if model.is_owned_by?(current_restaurant)
      @path = restaurant_table_path(model.restaurant, model)
      render
    end
  end

  def new_link
    if restaurant_signed_in?
      @path = new_restaurant_table_path(current_restaurant)
      render
    end
  end

  def show_link
    if model.is_owned_by?(current_restaurant)
      @path = restaurant_table_path(model.restaurant, model)
      render
    elsif admin_signed_in?
      @path = admin_table_path(model)
      render
    end
  end

  def edit_link
    if model.is_owned_by?(current_restaurant)
      @path = edit_restaurant_table_path(model.restaurant, model)
      render
    end
  end

  def reservations
    table "Reservations", \
      %w(User Occupied_slots Status Actions), \
      cell(:reservation, collection: model.reservations, method: :table_row)
  end

  def slots_left
    "#{model.male_slots_left}/#{model.female_slots_left}"
  end
end