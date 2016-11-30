require "administrate/base_dashboard"

class ShortenUrlDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    url: Field::String,
    natural_id: Field::String,
    display_name: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :url,
    :natural_id,
    :display_name,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :url,
    :natural_id,
    :display_name,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :url,
    :natural_id,
    :display_name,
  ].freeze

  # Overwrite this method to customize how shorten urls are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(shorten_url)
  #   "ShortenUrl ##{shorten_url.id}"
  # end
end
