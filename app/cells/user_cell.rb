class UserCell < BaseCell

# TODO ??? 
  def from_elasticsearch
    User.find(model.id)
  end

end
