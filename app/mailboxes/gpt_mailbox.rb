class GptMailbox < ApplicationMailbox
  def process
    Rails.logger.info { "Processing email from '#{mail.from}' to '#{mail.to}':" }
    Rails.logger.info { "-------------------------------" }
    Rails.logger.info { mail }
    Rails.logger.info { "-------------------------------" }
    if User.where(email: mail.from.first, status: ["paid", "admin"]).exists?
      question = (mail.text_part || mail.body).decoded
      #response = chat(question)
      response = "Got this: #{question}"
      Rails.logger.info { "Replying" }
      BotMailer.reply(mail.message_id, mail.to.first, mail.from.first, mail.subject, response).deliver_now
    else
      Rails.logger.info { "Bouncing" }
      #bounce_with BotMailer.bounce(mail.message_id, mail.from.first, mail.subject).deliver_now
      bounced!
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
