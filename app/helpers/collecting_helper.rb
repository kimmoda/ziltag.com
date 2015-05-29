module CollectingHelper
  # <a href="#" class="collect" data-precious><i class="fa fa-star"></i></a>
  # <a href="#" class="uncollect" data-precious-cancel><i class="fa fa-star"></i></a>
  def collecting_button post
    return unless user_signed_in?
    ret = ActiveSupport::SafeBuffer.new
    ret << link_to(fa(:star), collect_path(post_id: post.id),
      method: :post, remote: true, class: :collect,
      data: {post_id: post.id},
      style: (:'display:none' if current_user.collect? post)
    )
    ret << link_to(fa(:star), uncollect_path(post_id: post.id),
      method: :delete, remote: true, class: :uncollect,
      data: {post_id: post.id},
      style: (:'display:none' unless current_user.collect? post)
    )
  end

end
