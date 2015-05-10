module Notificable
  extend ActiveSupport::Concern
  included do
    after_create do |entity|
      Admin.notify_by_email "new", entity
    end
  end
end