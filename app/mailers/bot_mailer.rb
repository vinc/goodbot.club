class BotMailer < ApplicationMailer
  def bounce(message_id, user, subject)
    mail(reply_to: message_id, to: user, subject: subject)
  end

  def reply(message_id, bot, user, subject, response)
    @response = response
    mail(reply_to: message_id, from: bot, to: user, subject: subject)
  end
end
