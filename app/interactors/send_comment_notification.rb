# frozen_string_literal: true
require 'action_view/helpers'
class SendCommentNotification #:nodoc:
  include Interactor
  include ActionView::Helpers::DateHelper
  TEMPLATE_NAME = 'comment-notification-email'
  def initialize(comment)
    @comment = comment
    @ziltag = comment.ziltag
    @author = comment.user
    @sibling_commenters = comment.sibling_commenters.to_a
    @ziltag_author = comment.ziltag.user
    @website_owner = comment.ziltag.photo.box.user
    @unsubscriber_ids = comment.ziltag.unsubscribers
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
      subject: "#{@author.username} has commented on your ziltag!",
      from_email: 'robot@ziltag.com',
      from_name: 'Ziltag Robot',
      to: to,
      merge_vars: merge_vars
    }
  end

  def to
    @to ||= (
      users_to_send.map { |user| { email: user.email, name: user.username } }
    )
  end

  def users_to_send
    @users_to_send ||= (
      users = @sibling_commenters.dup
      users << @ziltag_author unless @sibling_commenters.include?(@ziltag_author)
      users.reject! { |user| @unsubscriber_ids.include?(user.id) }
      users
    )
  end

  def merge_vars
    users_to_send.map do |user|
      {
        rcpt: user.email,
        vars: vars(user)
      }
    end
  end

  def vars(user)
    [
      { name: 'USERNAME', content: user.username },
      { name: 'AUTHOR', content: @author.username },
      { name: 'AUTHOR_AVATAR', content: @author.avatar.thumb.url },
      { name: 'ZILTAG_IMAGE', content: @ziltag.share_image_url },
      { name: 'ZILTAG_URL', content: ziltag_url },
      { name: 'CONTENT', content: @comment.content },
      { name: 'TIME_AGO_IN_WORDS', content: time_ago }
    ]
  end

  def time_ago
    time_ago_in_words(@comment.created_at)
  end

  def host
    "https://#{Rails.configuration.action_mailer.default_url_options[:host]}"
  end

  def ziltag_url
    "#{host}/ziltags/#{@ziltag.slug}"
  end
end
