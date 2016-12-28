# frozen_string_literal: true
class CreateZiltag < Interactor2 #:nodoc
  NOTIFICATION_BLACK_LIST = {
    urls: %w(http://reviewmonster.org/zoho_forms/)
  }
  attr_reader :ziltag
  def initialize(user, map_id, x, y, content)
    @user = user
    @map_id = map_id
    @x = x
    @y = y
    @content = content
  end

  def perform
    @photo = Photo.find_by(natural_id: @map_id)
    fail! "map ID '#{@map_id}' not found" if @photo.nil?

    @ziltag = Ziltag.new(
      user: @user, photo: @photo, x: @x, y: @y, content: @content
    )
    owner = @photo.website.user

    if owner != @user && @photo.website.restricted
      fail! 'tagging operation is not permitted'
    end

    if @ziltag.save
      NotifySSE.perform(:create, @ziltag)
      unless @ziltag.photo&.href.start_with?(*NOTIFICATION_BLACK_LIST['urls'])
        NotifyFlowdockOfZiltagJob.perform_later @ziltag
      end
      if owner.ziltag_notification?
        unless @ziltag.user == owner || @ziltag.unsubscribers.include?(owner.id)
          SendZiltagNotificationJob.perform_later(@ziltag)
        end
      end
      unless @user.has_created_first_ziltag
        SendProductFeedbackEmailJob.perform_later(@user)
        @user.update_column(:has_created_first_ziltag, true)
      end
    else
      fail! @ziltag.errors.full_messages.first
    end
  end
end
