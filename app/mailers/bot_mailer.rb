class BotMailer < ApplicationMailer
  def bounce(user, subject)
    mail(to: user, subject: subject)
  end

  def reply(user, bot, subject, response)
    @response = response
    mail(from: bot, to: user, subject: subject)
  end
end
