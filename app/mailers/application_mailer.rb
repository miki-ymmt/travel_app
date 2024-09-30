# frozen_string_literal: true

# Mailerの基底クラス

class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
