class UserCell < BaseCell
  def gender
    model.is_gender_undefined? ? "---" : model.gender
  end

  def logout_link
    @path = auth_logout_path
    render
  end

  def show_link
    @path = user_path(model)
    render
  end

  def edit_link
    @path =  edit_user_path(model)
    render
  end

  def test_link
    @path = users_test_path
    render
  end
end