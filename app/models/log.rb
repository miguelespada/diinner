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

  def self.add entity
    self.create(:action => "new", :type => entity.model_name.param_key, :name => entity.name, :entity_id => entity.id)
  end
end