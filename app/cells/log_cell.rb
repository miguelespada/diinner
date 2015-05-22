class LogCell < BaseCell
  include ActionView::Helpers::DateHelper
  include Rails::Timeago::Helper

  def entity 
    @entity ||= model.get_entity
  end

  def log_info
    cell(model.klass, entity).call(:to_log) if !entity.nil?
  end

  def action
    model.to_s
  end

  def timeago
    timeago_tag entity.updated_at, :nojs => true, :limit => 10.days.ago if !entity.nil?
  end
end