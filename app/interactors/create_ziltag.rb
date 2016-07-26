class CreateZiltag
  include Interactor
  def initialize user, map_id, x, y, content
    @user, @map_id, @x, @y, @content = user, map_id, x, y, content
  end

  def call
    @photo = Photo.find_by(slug: @map_id)
    fail! "map ID '#{@map_id}' not found" if @photo.nil?

    ziltag = Ziltag.new(
      user: @user, photo: @photo, x: @x, y: @y, content: @content
    )
    owner = @photo.box.user

    if owner != @user && @photo.box.restricted
      fail! 'tagging operation is not permitted'
    end

    if ziltag.save
      unless ziltag.user == owner || ziltag.unsubscribers.include?(owner.id)
        SendZiltagNotificationJob.perform_later(ziltag)
      end
      unless @user.has_created_first_ziltag
        SendProductFeedbackEmailJob.perform_later(@user)
        @user.update_column(:has_created_first_ziltag, true)
      end
      context[:ziltag] = ziltag
    else
      fail! ziltag.errors.full_messages.first
    end
  end
end
