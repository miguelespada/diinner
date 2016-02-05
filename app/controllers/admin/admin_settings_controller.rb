class  Admin::AdminSettingsController < AdminController

  def edit
    @admin_settings = AdminSettings.get_first
  end

  def update
    @admin_settings = AdminSettings.get_first
    @admin_settings.update(admin_settings_params)
    redirect_to edit_admin_admin_settings_path, notice: 'Settings successfully updated.'
  end

  private

  def admin_settings_params
    params.require(:admin_settings).permit(AdminSettings.permitted_parameters)
  end

end