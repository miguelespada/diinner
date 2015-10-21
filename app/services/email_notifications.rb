module EmailNotifications

  def self.notify to, subject
    Pony.mail(:to => to,
              :from => "noreply@diinner.com",
              :subject => "[Diinner] #{subject}")
    
  end

end