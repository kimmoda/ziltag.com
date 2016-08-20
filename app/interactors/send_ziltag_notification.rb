# frozen_string_literal: true
require 'action_view/helpers'
class SendZiltagNotification #:nodoc:
  include Interactor
  include ActionView::Helpers::DateHelper
  TEMPLATE_NAME = 'ziltag-notification-email'
  def initialize(ziltag)
    @ziltag = ziltag
    @author = ziltag.user
    @website_owner = @ziltag.photo.website.user
  end

  def call
    context[:result] = MANDRILL_CLIENT.messages.send_template TEMPLATE_NAME,
                                                              [],
                                                              message
  rescue
    fail! $ERROR_INFO
  end

  def message
    {
      subject: "#{@author.username} has posted a new ziltag on your image!",
      from_email: 'robot@ziltag.com',
      from_name: 'Ziltag Robot',
      to: [{ email: @website_owner.email, name: @website_owner.username }],
      merge_vars: merge_vars
    }
  end

  def merge_vars
    [
      {
        rcpt: @website_owner.email,
        vars: vars
      }
    ]
  end

  def vars
    [
      { name: 'USERNAME', content: @website_owner.username },
      { name: 'AUTHOR', content: @author.username },
      { name: 'AUTHOR_AVATAR', content: @author.avatar.thumb.url },
      { name: 'ZILTAG_IMAGE', content: @ziltag.share_image_url },
      { name: 'ZILTAG_URL', content: ziltag_url },
      { name: 'CONTENT', content: @ziltag.content },
      { name: 'TIME_AGO_IN_WORDS', content: time_ago }
    ]
  end

  def time_ago
    time_ago_in_words(@ziltag.created_at)
  end

  def host
    "https://#{Rails.configuration.action_mailer.default_url_options[:host]}"
  end

  def ziltag_url
    "#{host}/ziltags/#{@ziltag.slug}"
  end
end
