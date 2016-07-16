# frozen_string_literal: true
class ChangeMailchimpRole #:nodoc:
  include Interactor
  VALID_ROLES = %w(subscriber general partner).freeze

  def initialize(user, role)
    @user = user
    @role = role
    raise "valid roles: #{VALID_ROLES.join(', ')}" unless VALID_ROLES.include? role
  end

  def call
    list_id = if Rails.env.production?
                Settings.gibbon.list_id
              else
                'b4afffcd4b'
              end
    subscriber_hash = Digest::MD5.hexdigest(@user.email)
    context[:result] = Gibbon::Request.lists(list_id).members(subscriber_hash).update(body: body)
  end

  def body
    {
      merge_fields: {
        ROLE: @role
      }
    }
  end
end
