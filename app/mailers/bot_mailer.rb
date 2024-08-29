class BotMailer < ApplicationMailer
  def reply(mail, req, res)
    @date = mail.date.strftime("%a, %b %d, %Y at %I:%M %p")
    @from = mail.from.first
    @req = req
    @res = res
    mail(
      in_reply_to: mail.message_id,
      from: mail.to.first,
      to: mail.from.first,
      subject: mail.subject
    )
  end

  def bounce(mail)
    mail(
      in_reply_to: mail.message_id,
      to: mail.from.first,
      subject: mail.subject
    )
  end
end
