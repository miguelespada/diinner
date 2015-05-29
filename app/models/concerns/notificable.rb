module Notificable
  extend ActiveSupport::Concern
  # included do
    
  #   after_create do |entity|
  #     notify_by_email entity
  #   end

  #   def notify_by_email entity
  #       @log ||= entity.to_log
  #       Admin.each do |admin|
  #         @log.notify admin.email
  #       end
  #   end

  # end
end