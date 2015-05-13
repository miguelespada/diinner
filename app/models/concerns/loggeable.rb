module Loggeable
  extend ActiveSupport::Concern
  included do
    after_create do |entity|
      @log = Log.create( 
          :action => "new",
          :klass => entity.model_name.param_key, 
          :entity_id => entity.id)
    end
  end
end