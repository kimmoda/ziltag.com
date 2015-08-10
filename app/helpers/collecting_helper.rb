=begin
<div class="collecting-button" data-id="ID" data-type="TYPE">
  <i class="fa fa-heart collecting-button__collect"></i>
  <i class="fa fa-heart collecting-button__uncollect"></i>
</div>
=end

module CollectingHelper
  def collecting_button record
    return unless user_signed_in?
    return if record.try(:user) == current_user
    content_tag :div, class: 'collecting-button', data: {id: record.id, type: record.class.name} do
      concat content_tag :i, nil, class: 'fa fa-heart collecting-button__collect', style: (:'display:none' if current_user.collect? record)
      concat content_tag :i, nil, class: 'fa fa-heart collecting-button__uncollect', style: (:'display:none' unless current_user.collect? record)
    end
  end

end
