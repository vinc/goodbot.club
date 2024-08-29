class BotMailer < ApplicationMailer
  def reply(bot, mail, req, res)
    @date = mail.date.strftime("%a, %b %d, %Y at %I:%M %p")
    @from = mail.from.first
    @req = req
    @res = res
    mail(
      from: bot,
      to: mail.from.first,
      in_reply_to: mail.message_id,
      subject: mail.subject
    )
  end

  def bounce(bot, mail)
    mail(
      from: bot,
      to: mail.from.first,
      in_reply_to: mail.message_id,
      subject: mail.subject
    )
  end
end
