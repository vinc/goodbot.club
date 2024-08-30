class ApplicationMailbox < ActionMailbox::Base
  routing(/^claude@/i => :claude)
  routing(/^gemini@/i => :gemini)
  routing(/^gpt@/i => :gpt)
end
