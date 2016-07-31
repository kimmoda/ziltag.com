# frozen_string_literal: true
class GetUserPermissions < Interactor2 #:nodoc:
  attr_reader :permissions
  ACTIONS = %w(create read update delete).freeze
  RESOURCES = %w(ziltag comment).freeze
  DEFAULT_PERMISSIONS = ACTIONS.product(RESOURCES)
                               .map! { |pair| "#{pair.first}_#{pair.last}" }
                               .freeze

  def initialize(user, token)
    @user = user
    @token = token
    @permissions = DEFAULT_PERMISSIONS.dup
  end

  def perform
    box = Box.find_by(token: @token)
    fail! 'toke not found' if box.nil?
    if box.restricted && @user != box.user
      @permissions -= %w(create_ziltag update_ziltag delete_ziltag)
    end
  end
end
