class UserCell < BaseCell
  def gender
    model.is_gender_undefined? ? "---" : model.gender
  end
end