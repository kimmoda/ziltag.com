class NotifyOfZiltag
  def initialize ziltag
    @ziltag = ziltag
  end

  def call
    user = @ziltag.photo.box.user
    return if user == @ziltag.user
    unless @ziltag.unsubscribers.include?(user.id)
      NotificationMailer.new_ziltag_notification(user, @ziltag).deliver_later
    end
  end
end