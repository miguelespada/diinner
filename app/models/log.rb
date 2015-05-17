class Log
  include Mongoid::Document
  include Mongoid::Timestamps

  field :action,    type: String
  field :klass,    type: String
  field :entity_id,    type: String


  def get_entity
    @entity ||= klass.classify.safe_constantize.find(entity_id)
  rescue 
    nil
  end

  def to_s
    "#{action} #{klass}".capitalize
  end

  def notify to
    Pony.mail(:to => to, 
              :from => "noreply@diinner.com", 
              :subject => "[Diinner] #{self.to_s}")
    rescue Exception => exc
      logger.error("Error sending email notification #{exc.message}")
  end
end