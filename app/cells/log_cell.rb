class LogCell < BaseCell

  def entity 
    @entity ||= model.get_entity
  end

  def entity_link
    link_to model.name, send("admin_#{model.type}_path", entity)
  end

  def action
    (model.action + " " + model.type).capitalize
  end
end