class  Admin::HomeItemsController < AdminController

  def edit
    @home_item = HomeItem.get_first
  end

  def update
    @home_item = HomeItem.get_first
    @home_item.update(home_item_params)
    expire_action(:controller => 'StaticController', :action => 'index')
    redirect_to edit_admin_home_items_path, notice: 'Home was successfully updated.'
  end

  private

  def home_item_params
    params.require(:home_item).permit(:header,
                                      :mobile_background,
                                      :restaurant_sample_1_id,
                                      :restaurant_sample_2_id,
                                      :restaurant_sample_3_id
                                      )
  end

end