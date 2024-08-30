class GeminiMailbox < BotMailbox
  def bot
    "gemini@goodbot.club"
  end

  def chat(text)
    # return "Hello from Gemini"
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
