class ApplicationMailbox < ActionMailbox::Base
  # An email sent to multiple bots via the "To" header is received multiple
  # times with only the "Received" headers changing.
  routing ->(inbound) { self.received_for?(inbound.mail, /claude@/) } => :claude
  routing ->(inbound) { self.received_for?(inbound.mail, /gemini@/) } => :gemini
  routing ->(inbound) { self.received_for?(inbound.mail, /gpt@/) } => :gpt

  routing(/^claude@/i => :claude)
  routing(/^gemini@/i => :gemini)
  routing(/^gpt@/i => :gpt)

  def self.received_for?(mail, addr)
    mail.received.any? { |field| field.value =~ addr }
  end
end
