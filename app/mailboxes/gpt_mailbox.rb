class GptMailbox < ApplicationMailbox
  def process
    question = mail.body.decoded
    response = chat(question)
    BotMailer.reply(mail.to, mail.from, mail.subject, response).deliver_now
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
