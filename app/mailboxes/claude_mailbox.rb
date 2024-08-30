class ClaudeMailbox < ApplicationMailbox
  NAME="claude@goodbot.club"

  def process
    Rails.logger.info { mail }
    if User.where(email: mail.from.first, status: ["paid", "admin"]).exists?
      req = (mail.text_part || mail.body).decoded
      res = chat(req)
      BotMailer.reply(NAME, mail, req, res).deliver_now
    else
      # bounce_with BotMailer.bounce(NAME, mail).deliver_now
      bounced!
    end
  end

  protected

  def chat(text)
    client = Anthropic::Client.new(access_token: ENV["ANTHROPIC_ACCESS_TOKEN"])
    result = client.messages(
      parameters: {
        model: "claude-3-sonnet-20240229",
        system: "",
        messages: [{ "role": "user", "content": text }],
        max_tokens: 2000
      }
    )
    result.dig("content", 0, "text")
  end
end
