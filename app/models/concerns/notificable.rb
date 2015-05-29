module Notificable
  extend ActiveSupport::Concern

  # def notify to
  #   Pony.mail(:to => to, 
  #             :from => "noreply@diinner.com", 
  #             :subject => "[Diinner] #{self.to_s}")
  #   rescue Exception => exc
  #     logger.error("Error sending email notification #{exc.message}")
  # end

end