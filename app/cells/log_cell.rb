class LogCell < BaseCell
  def action
    (model.action + " " + model.type).capitalize
  end
end