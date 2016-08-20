# frozen_string_literal: true

# subscribe ziltag's mailchimp
class SubscribeNewsletter < Interactor2
  def initialize(user)
    @user = user
  end

  def perform
    list_id = if Rails.env.production?
                Settings.gibbon.list_id
              else
                'b4afffcd4b'
              end
    Gibbon::Request.lists(list_id).members.create(body: body)
  end

  private

  def body
    {
      email_address: @user.email,
      status: 'subscribed',
      merge_fields: {
        USERNAME: @user.username,
        ROLE: @user.partner? ? 'partner' : 'general'
      }
    }
  end
end
