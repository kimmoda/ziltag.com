# frozen_string_literal: true
class ApplicationMailer < ActionMailer::Base
  default from: 'Ziltag Robot <robot@ziltag.com>'
  layout 'mailer'
end
