class GptMailbox < ApplicationMailbox
  def process
    if User.where(email: mail.from, status: ["paid", "admin"]).exists?
      question = mail.body.decoded
      response = chat(question)
      #BotMailer.reply(mail.to, mail.from, mail.subject, response).deliver_now
    else
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
