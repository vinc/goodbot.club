class GeminiMailbox < ApplicationMailbox
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
    client = Gemini.new(
      credentials: {
        service: "generative-language-api",
        api_key: ENV["GOOGLE_ACCESS_TOKEN"]
      },
      options: {
        model: "gemini-pro",
        server_sent_events: true
      }
    )
    result = client.generate_content({
      contents: { role: "user", parts: { text: text } }
    })
    result.dig("candidates", 0, "content", "parts", 0, "text")
  end
end
