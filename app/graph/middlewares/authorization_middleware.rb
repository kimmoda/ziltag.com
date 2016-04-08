class AuthorizationMiddleware
  def call(parent_type, parent_object, field_definition, field_args, query_context, next_middleware)
    current_user = query_context[:current_user]
    case parent_type
    when MutationType
      raise 'user is not signed in' if current_user.nil?
      case field_definition.name
      when 'createZiltag'
      when 'updateZiltag'
        ziltag = Ziltag.find_by! slug: field_args[:id]
        raise "Ziltag '#{ziltag.slug}' is not writable for the user '#{current_user.username}'" if ziltag.user_id != current_user.id
      end
    end
    next_middleware.call
  end
end