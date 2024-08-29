class GptMailbox < ApplicationMailbox
  def process
    Rails.logger.info { "Processing email from '#{mail.from}' to '#{mail.to}':" }
    Rails.logger.info { "-------------------------------" }
    Rails.logger.info { mail }
    Rails.logger.info { "-------------------------------" }
    if User.where(email: mail.from.first, status: ["paid", "admin"]).exists?
      req = (mail.text_part || mail.body).decoded
      Rails.logger.info { "-------------------------------" }
      Rails.logger.info { req }
      Rails.logger.info { "-------------------------------" }
      # res = chat(req)
      res = "Got your email!"
      Rails.logger.info { "Replying" }
      BotMailer.reply(mail, req, res).deliver_now
    else
      Rails.logger.info { "Bouncing" }
      # bounce_with BotMailer.bounce(mail).deliver_now
      bounced!
    end
  end

  protected

  def chat(req)
    client = OpenAI::Client.new
    res = client.chat(
      parameters: {
          model: "gpt-4o",
          messages: [{ role: "user", content: req }],
          temperature: 0.7
      }
    )
    res.dig("choices", 0, "message", "content")
  end
end
