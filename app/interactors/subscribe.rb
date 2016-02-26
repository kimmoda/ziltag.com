class Subscribe
  def initialize user, ziltag
    @user, @ziltag = user, ziltag
  end

  def call
    return unless @ziltag.unsubscribers.include? @user.id
    @ziltag.unsubscribers.delete(@user.id)
    @ziltag.save!
  end
end