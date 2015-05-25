class CityCell < BaseCell

  def delete_link
    if admin_signed_in?
     @path = admin_city_path(model)
     render
    end
  end

  def edit_link
    if admin_signed_in?
      @path = edit_admin_city_path(model)
      render
    end
  end

  def show_link
    if admin_signed_in?
      @path = admin_map_path({:city => {:city => model.name}})
      render
    end
  end

  def show_icon
    if admin_signed_in?
      @path = admin_city_path(model)
      render
    end
  end

  def new_link
    if admin_signed_in?
      @path = new_admin_city_path
      render
    end
  end

end