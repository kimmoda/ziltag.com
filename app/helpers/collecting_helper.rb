module CollectingHelper
  # <a href="#" class="btn_precious" data-precious><i class="fa fa-star"></i></a>
  # <a href="#" class="btn_precious cancel" data-precious-cancel><i class="fa fa-star"></i></a>
  def collecting_button post
    return unless user_signed_in?
    ret = ActiveSupport::SafeBuffer.new
    ret << link_to(fa(:star), collect_path(post_id: post.id),
      method: :post, remote: true, class: :btn_precious,
      data: {precious: '', post_id: post.id},
      style: (:'display:none' if current_user.collect? post)
    )
    ret << link_to(fa(:star), uncollect_path(post_id: post.id),
      method: :delete, remote: true, class: :'btn_precious cancel',
      data: {precious_cancel: '', post_id: post.id},
      style: (:'display:none' unless current_user.collect? post)
    )
  end

end
