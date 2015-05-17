class AdminCell < BaseCell
  def logout_link
    if admin_signed_in?
      @path = destroy_admin_session_path
      render
    end
  end
end