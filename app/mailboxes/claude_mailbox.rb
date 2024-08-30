class ClaudeMailbox < BotMailbox
  def bot
    "claude@goodbot.club"
  end

  def chat(text)
    # return "Hello from Claude"
    client = Anthropic::Client.new(access_token: ENV["ANTHROPIC_ACCESS_TOKEN"])
    result = client.messages(
      parameters: {
        model: "claude-3-5-sonnet-20240620",
        system: "",
        messages: [{ "role": "user", "content": text }],
        max_tokens: 2000
      }
    )
    result.dig("content", 0, "text")
  end
end
