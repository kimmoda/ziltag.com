require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    username: Field::String,
    email: Field::Email,
    avatar: Field::Image,
    type: Field::String,
    notification: Field::Boolean,
    ziltags: Field::HasMany,
    comments: Field::HasMany,
    boxes: Field::HasMany,
    sign_in_count: Field::Number,
    current_sign_in_at: Field::DateTime,
    current_sign_in_ip: Field::String,
    last_sign_in_ip: Field::String,
    unconfirmed_email: Field::String,
    confirmation_sent_at: Field::DateTime,
    # reset_password_sent_at: Field::DateTime,
    confirmed_at: Field::DateTime,
    last_sign_in_at: Field::DateTime,
    remember_created_at: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :avatar,
    :type,
    :email,
    :username,
    :ziltags,
    :comments,
    :boxes,
    :confirmed_at,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :ziltags,
    :comments,
    :boxes,
    :email,
    :avatar,
    :username,
    :type,
    :notification,
  ]
end
