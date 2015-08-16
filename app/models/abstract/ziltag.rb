class Abstract::Ziltag
  include ActiveModel::Model
  attr_accessor :photo, :ziltagging, :ziltaggable

  def save!
    ActiveRecord::Base.transaction do
      @photo.save!
      @ziltaggable.save!
      @ziltagging.assign_attributes photo: @photo, ziltaggable: @ziltaggable
      @ziltagging.save!
    end
  end

  def post
    ziltaggable
  end

  def post= post
    self.ziltaggable = post
  end

end