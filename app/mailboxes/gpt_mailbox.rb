class GptMailbox < ApplicationMailbox
  def process
    Rails.logger.info { "Processing email from '#{mail.from}' to '#{mail.to}':" }
    Rails.logger.info { "-------------------------------" }
    Rails.logger.info { mail }
    Rails.logger.info { "-------------------------------" }
    if User.where(email: mail.from, status: ["paid", "admin"]).exists?
      question = (mail.text_part || mail.body).decoded
      response = chat(question)
      Rails.logger.info { "Replying" }
      BotMailer.reply(mail.to, mail.from, mail.subject, response).deliver_now
    else
      Rails.logger.info { "Bouncing" }
      #bounce_with BotMailer.bounce(mail.from, mail.subject).deliver_now
    end
  end

  protected

  def chat(question)
    client = OpenAI::Client.new
    res = client.chat(
      parameters: {
          model: "gpt-4o",
          messages: [{ role: "user", content: question }],
          temperature: 0.7
      }
    )
    res.dig("choices", 0, "message", "content")
  end
end
