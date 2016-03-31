class NotifyOfZiltag
  include Interactor

  def initialize ziltag
    @ziltag = ziltag
    @ziltag_author = ziltag.user
    @website_owner = @ziltag.photo.box.user
  end

  def call
    return if @website_owner == @ziltag_author
    unless @ziltag.unsubscribers.include?(@website_owner.id)
      NotificationMailer.new_ziltag_notification(@website_owner, @ziltag).deliver_later
    end
  end
end