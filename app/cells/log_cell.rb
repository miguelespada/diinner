class LogCell < BaseCell

  def entity 
    @entity ||= model.get_entity
  end

  def log_info
    cell(model.klass, entity).call(:to_log)
  end

  def action
    model.to_s
  end
end