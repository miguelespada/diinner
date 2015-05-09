module Loggeable
  extend ActiveSupport::Concern
  included do
    after_create do |entity|
      Admin.log "new", entity
    end
  end
end