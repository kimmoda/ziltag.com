class AuthorizationMiddleware
  def call(parent_type, parent_object, field_definition, field_args, query_context, next_middleware)
    case parent_type
    when MutationType
      case field_definition.name
      when 'createZiltag'
        raise 'user must sign in to creat ziltag' if query_context[:current_user].nil?
      end
    end
    next_middleware.call
  end
end