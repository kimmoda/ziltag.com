# frozen_string_literal: true
class NotifySSE < Interactor2 #:nodoc:
  ACTIONS = %i(create update delete).freeze
  attr_reader :action, :record, :notification
  def initialize(action, record)
    @action = action
    @record = record
  end

  def perform
    validate_action
    case @record
    when Ziltag then notify_ziltag
    when Comment then notify_comment
    else fail! 'record should be instance of either Ziltag or Comment'
    end
  end

  def notify_ziltag
    ziltag = @record
    @notification = SseNotification.create body: {
      event: "#{@action}_ziltag",
      receivers: {
        ziltags: ziltag.photo.ziltags.pluck(:natural_id) << ziltag.natural_id,
        ziltag_maps: [ziltag.photo.natural_id]
      },
      payload: {
        map_id: ziltag.photo.natural_id, content: ziltag.content,
        id: ziltag.natural_id, x: ziltag.x.to_f, y: ziltag.y.to_f,
        usr: {
          avatar: ziltag.user.avatar.thumb.url, name: ziltag.user.username
        }
      }
    }
    if @notification.persisted?
      Ziltag.connection.execute "NOTIFY notification, '#{@notification.id}'"
    else
      fail! 'cannot create notification'
    end
  end

  def notify_comment
    comment = @record
    @notification = SseNotification.create body: {
      event: "#{@action}_comment",
      receivers: { ziltags: [comment.ziltag.natural_id] },
      payload: {
        ziltag_id: comment.ziltag.natural_id, id: comment.id,
        content: comment.content, created_at: comment.created_at,
        usr: {
          avatar: comment.user.avatar.thumb.url, name: comment.user.username
        }
      }
    }
    if @notification.persisted?
      Ziltag.connection.execute "NOTIFY notification, '#{@notification.id}'"
    else
      fail! 'cannot create notification'
    end
  end

  private

  def validate_action
    unless ACTIONS.include? @action
      fail! "action should be one of #{ACTIONS.join(', ')}"
    end
  end
end
