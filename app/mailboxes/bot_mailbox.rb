class BotMailbox < ApplicationMailbox
  before_processing :ensure_sender_is_a_paid_user

  def process
    Rails.logger.info { mail }
    req = (mail.text_part || mail.body).decoded
    res = chat(req)
    BotMailer.reply(bot, mail, req, res).deliver_now
  end

  def bot
    "bot@goodbot.club"
  end

  def chat(text)
    "Hello, World!"
  end

  protected

  def ensure_sender_is_a_paid_user
    bounced! unless User.where(email: mail.from.first, status: ["paid", "admin"]).exists?
  end
end
