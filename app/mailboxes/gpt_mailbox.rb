class GptMailbox < BotMailbox
  def bot
    "gpt@goodbot.club"
  end

  def chat(text)
    # return "Hello from GPT"
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
