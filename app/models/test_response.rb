class TestResponse
  include Mongoid::Document
  include Mongoid::Timestamps
  include Loggeable
  
  belongs_to :user, autosave: :true
  belongs_to :test, autosave: :true

  field :response, type: String

  def to_log
    @log = Log.create(:action => "new", 
        :type => test.model_name.param_key, 
        :name => response, 
        :entity_id => test.id)
  end

end