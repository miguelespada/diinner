class UserCell < BaseCell
  def gender
    model.gender ? "Female" : "Male"
  end
end