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

  def to_s
    "#{action.capitalize} #{type}: #{name}"
  end

  def notify to
    Pony.mail(:to => to, 
              :from => "noreply@diinner.com", 
              :subject => "[Diinner] #{self.to_s}")
  end
end