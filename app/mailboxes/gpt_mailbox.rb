class GptMailbox < ApplicationMailbox
  def process
    Rails.logger.info { mail }
    if User.where(email: mail.from.first, status: ["paid", "admin"]).exists?
      req = (mail.text_part || mail.body).decoded
      res = chat(req)
      BotMailer.reply(mail, req, res).deliver_now
    else
      # bounce_with BotMailer.bounce(mail).deliver_now
      bounced!
    end
  end

  protected

  def chat(req)
    return "It works!"

    client = OpenAI::Client.new
    res = client.chat(
      parameters: {
          model: "gpt-4o-mini",
          messages: [{ role: "user", content: req }],
          temperature: 0.7
      }
    )
    res.dig("choices", 0, "message", "content")
  end
end
