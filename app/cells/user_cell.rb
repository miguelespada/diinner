class UserCell < BaseCell

  def gender
    model.undefined? ? "---" : model.gender
  end

  def logout_link
    if user_signed_in?
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
    elsif model.is_owned_by?(current_user)
      @path = edit_user_path(model)
    end
    render unless @path.nil?
  end

  def test_link
    if model.is_owned_by?(current_user)
      @path = user_test_path(model)
      render
    end
  end

  def test_responses
    if admin_signed_in?
      render
    end
  end
end