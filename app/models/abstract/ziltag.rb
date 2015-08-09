class Abstract::Ziltag
  include ActiveModel::Model
  attr_accessor :photo, :post, :ziltagging

  def save!
    ActiveRecord::Base.transaction do
      @photo.save!
      @post.save!
      @ziltagging.assign_attributes photo: @photo, post: @post
      @ziltagging.save!
    end
  end

end