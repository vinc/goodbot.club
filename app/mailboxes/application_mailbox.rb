class ApplicationMailbox < ActionMailbox::Base
  routing(/^gpt@/i => :gpt)
  routing(/^gemini@/i => :gemini)
end
