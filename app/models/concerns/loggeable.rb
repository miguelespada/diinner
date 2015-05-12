module Loggeable
  extend ActiveSupport::Concern
  included do
    after_create do |entity|
      entity.to_log
    end
  end
end