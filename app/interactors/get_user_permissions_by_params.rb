# frozen_string_literal: true

class GetUserPermissionsByParams < Interactor2 #:nodoc:
  attr_reader :permissions
  # params must be either {token:} (for plugin)
  # or {ziltag_map_id:} (for reader)
  def initialize(user, params = {})
    @user = user
    @token = params[:token]
    @ziltag_map_id = params[:ziltag_map_id]
  end

  def perform
    result = GetUserPermissions.perform(@user, website)
    result.success? ? @permissions = result.permissions : fail!(result.error)
  end

  def website
    @_website ||= (
      if @token
        _website = Website.find_by(token: @token)
        _website || fail!('token is not valid')
      elsif @ziltag_map_id
        photo = Photo.find_by(slug: @ziltag_map_id)
        photo || fail!('zilag_map id is not valid')
        _website = photo.website
        _website || fail!("can't get plugin token from ziltag_map #{@ziltag_map_id}")
      else
        fail! 'missing parameters: either `token` (for plugin) or `ziltag_map_id` (for ziltag and ziltag map page)'
      end
    )
  end
end
