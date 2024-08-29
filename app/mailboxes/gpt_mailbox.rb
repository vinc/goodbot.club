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

  def chat(text)
    client = OpenAI::Client.new
    result = client.chat(
      parameters: {
          model: "gpt-4o",
          messages: [{ role: "user", content: text }],
          temperature: 0.7
      }
    )
    result.dig("choices", 0, "message", "content")
  end
end
