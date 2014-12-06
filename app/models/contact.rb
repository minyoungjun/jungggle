class Contact < ActiveRecord::Base
  def send_mail
    case self.contact_type
    when 0
      contact_type = "Customer Support"
    when 1
      contact_type = "Feedback"
    when 2
      contact_type = "Press"
    end
    RestClient.post "https://api:key-d9dd9c0e53befa87a8e213df42ba5da0"\
      "@api.mailgun.net/v2/jungggle.com/messages",
      :from => "#{self.name} <#{self.email}>",
      :to => "contact@gameberry.co.kr",
      :subject => "[#{contact_type}] Contact Message!",
      :html => "<p>Name: #{self.name}<br>Company: #{self.company_name}<br>Email Address: #{self.email}<br>Message: #{self.content}"

  end
end
