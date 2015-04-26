class UserCell < BaseCell

  def from_elasticsearch
    User.find(model.id)
  end

end
