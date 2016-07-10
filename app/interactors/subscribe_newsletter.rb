# frozen_string_literal: true

# subscribe ziltag's mailchimp
class SubscribeNewsletter
  include Interactor

  def initialize(user)
    @user = user
  end

  def call
    list_id = if Rails.env.production?
                list_name
              else
                'b4afffcd4b'
              end
    Gibbon::Request.lists(list_id).members.create(body: body)
  rescue
    fail! $ERROR_INFO
  end

  private

  def list_name
    if @user.content_provider?
      Settings.gibbon.partner_list_id
    else
      Settings.gibbon.user_list_id
    end
  end

  def body
    {
      email_address: @user.email,
      status: 'subscribed',
      merge_fields: {
        FNAME: @user.username
      }
    }
  end
end
