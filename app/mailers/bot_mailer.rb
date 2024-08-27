class BotMailer < ApplicationMailer
  def reply(from, to, subject, response)
    @response = response
    mail(from: from, to: to, subject: subject)
  end
end
