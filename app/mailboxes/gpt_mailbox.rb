class GptMailbox < ApplicationMailbox
  def process
    response = "Hello"
    BotMailer.reply(mail.to, mail.from, mail.subject, response).deliver_now
  end
end
