class ShortenUrl < ActiveRecord::Base
  include Natural
  # scopes

  # constants

  # attributes

  # associations

  # validations

  # callbacks
  after_update :update_photo_namespace, if: :natural_id_changed?

  # other

  private

  def update_photo_namespace
    Photo.where(namespace: natural_id_was).update_all(namespace: natural_id)
  end
end
