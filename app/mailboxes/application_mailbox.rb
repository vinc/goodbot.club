class ApplicationMailbox < ActionMailbox::Base
  routing(/^gpt@/i => :gpt)
end
