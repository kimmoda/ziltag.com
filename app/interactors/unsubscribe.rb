class Unsubscribe
  def self.verify token
    Rails.application.message_verifier(:unsubscribe).verify(token)
  end

  def initialize user, ziltag
    @user, @ziltag = user, ziltag
  end

  def token
    Rails.application.message_verifier(:unsubscribe).generate([@user.id, @ziltag.id])
  end

  def call
    return if @ziltag.unsubscribers.include? @user.id
    @ziltag.unsubscribers << @user.id
    @ziltag.save!
  end
end
