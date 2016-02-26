class NotificationMailer < ApplicationMailer
  def new_comment_notification(user, comment)
    @user = user
    @comment = comment
    @partner_link = !@user.is_a?(ContentProvider)
    @unsubscribe_token = Unsubscribe.new(@user, @comment.ziltag).token
    mail to: @user.email do |format|
      format.html{ render_inline_css __method__ }
    end
  end
end
