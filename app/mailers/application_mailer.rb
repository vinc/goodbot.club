class ApplicationMailer < ActionMailer::Base
  default from: "bot@goodbot.club"
  layout "mailer"
  helper ApplicationHelper
end
