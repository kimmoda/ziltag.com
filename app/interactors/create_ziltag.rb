class CreateZiltag
  include Interactor
  def initialize user, map_id, x, y, content
    @user, @map_id, @x, @y, @content = user, map_id, x, y, content
  end

  def call
    @photo = Photo.find_by(slug: @map_id)
    fail! "map ID '#{@map_id}' not found" if @photo.nil?

    ziltag = Ziltag.new(user: @user, photo: @photo, x: @x, y: @y, content: @content)

    if ziltag.save
      NotifyOfZiltag.call(ziltag)
      unless @user.has_created_first_ziltag
        SendProductFeedbackEmailJob.set(wait: 2.weeks)
                                   .perform_later(@user)
        @user.update_column(:has_created_first_ziltag, true)
      end
      context[:ziltag] = ziltag
    else
      fail! ziltag.errors.full_messages.first
    end
  end
end