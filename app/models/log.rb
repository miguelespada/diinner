class Log
  include Mongoid::Document
  include Mongoid::Timestamps

  field :action,    type: String
  field :type,    type: String
  field :name,    type: String
  field :entity_id,    type: String

  def get_entity
    @entity ||= type.classify.safe_constantize.find(entity_id)
  end

end