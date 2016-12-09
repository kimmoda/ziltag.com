# frozen_string_literal: true
require 'action_view/helpers'
class SendCommentNotification < Interactor2 #:nodoc:
  TEMPLATE_NAME = 'comment-notification-email'
  include ActionView::Helpers::DateHelper
  attr_reader :result

  def initialize(comment)
    @comment = comment
    @ziltag = comment.ziltag
    @author = comment.user
    @sibling_commenters = comment.sibling_commenters.to_a
    @ziltag_author = comment.ziltag.user
    @website_owner = comment.ziltag.photo.website.user
    @unsubscriber_ids = comment.ziltag.unsubscribers
  end

  def perform
    @result = MANDRILL_CLIENT.messages.send_template TEMPLATE_NAME,
                                                     [],
                                                     message
  end

  def message
    {
      subject: "#{@author.username} has commented on your ziltag!",
      from_email: 'robot@ziltag.com',
      from_name: 'Ziltag',
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
      unless @ziltag_author == @author
        users << @ziltag_author unless @sibling_commenters.include?(@ziltag_author)
      end
      users.reject! do |user|
        !user.comment_notification? || @unsubscriber_ids.include?(user.id)
      end
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
      { name: 'TIME_AGO_IN_WORDS', content: time_ago },
      { name: 'UNSUBSCRIBE_URL', content: unsubscribe_url(user, @ziltag) }
    ]
  end

  def unsubscribe_url(user, ziltag)
    token = Unsubscribe.new(user, ziltag).token
    encoded_token = URI.encode_www_form_component(token)
    "#{host}/unsubscribe?token=#{encoded_token}"
  end

  def time_ago
    time_ago_in_words(@comment.created_at)
  end

  def host
    "https://#{Rails.configuration.action_mailer.default_url_options[:host]}"
  end

  def ziltag_url
    "#{host}/ziltags/#{@ziltag.natural_id}"
  end
end
