class MistralMailbox < BotMailbox
  def bot
    "mistral@goodbot.club"
  end

  def chat(text)
    # return "Hello from Mistral"
    client = Mistral.new(
      credentials: { api_key: ENV["MISTRAL_ACCESS_TOKEN"] },
      options: { server_sent_events: true }
    )
    result = client.chat_completions({
      model: "mistral-large-latest",
      messages: [{ role: "user", content: text }]
    })
    result.dig("choices", 0, "message", "content")
  end
end
