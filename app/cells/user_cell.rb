class UserCell < BaseCell

  def gender
    model.is_gender_undefined? ? "---" : model.gender
  end

  def logout_link
   # TODO  WTF No añadir features sin test.
   # Quizás es mejor ponerlo en positivo
    # if user_signed_in?
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
    elsif model.is_owned_by?(current_user)
      @path = edit_user_path(model)
    end
    render unless @path.nil?
  end

  def test_link
   # TODO  WTF No añadir features sin test.
   # Quizás es mejor ponerlo en positivo
   # if model.is_owned_by?(current_user)
    if !admin_signed_in?
      @path = users_test_path
      render
    end
  end
end