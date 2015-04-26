class UserCell < BaseCell

# TODO ??? 
# TODO View accessing the model!!! WTF!

  def from_elasticsearch
    User.find(model.id)
  end

end
