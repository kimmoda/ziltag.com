# frozen_string_literal: true

# subscribe ziltag's mailchimp
class SubscribeNewsletter
  include Interactor

  def initialize(user)
    @user = user
  end

  def call
    list_id = if Rails.env.production?
                Settings.gibbon.list_id
              else
                'b4afffcd4b'
              end
    Gibbon::Request.lists(list_id).members.create(body: gibbon_body)
  rescue
    fail! $ERROR_INFO
  end

  private

  def gibbon_body
    {
      email_address: @user.email,
      status: 'subscribed',
      merge_fields: {
        FNAME: @user.username
      }
    }
  end
end
