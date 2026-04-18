class EventMailer < ApplicationMailer
  def notice_event(user, title, body)
    @body = body
    mail(to: user.email, subject: title)
  end
end
