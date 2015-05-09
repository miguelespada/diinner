class UserCell < BaseCell
  def gender
    model.is_gender_undefined? ? "---" : model.gender
  end

  def logout_link
    if !admin_signed_in?
      @path = auth_logout_path
      render
    end
  end

  def show_link
    if admin_signed_in?
      @path = admin_user_path(model)
    else
      @path = user_path(model)
    end
    render
  end

  def edit_link
    if admin_signed_in?
      @path = edit_admin_user_path(model)
    else
      @path = edit_user_path(model)
    end
    render unless @path.nil?
  end

  def test_link
    if !admin_signed_in?
      @path = users_test_path
      render
    end
  end
end