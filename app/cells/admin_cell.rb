class AdminCell < BaseCell
  def logout_link
   @path = destroy_admin_session_path
   render
  end
end