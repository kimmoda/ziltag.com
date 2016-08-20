# frozen_string_literal: true
class AuthorizationMiddleware
  def call(parent_type, _parent_object, field_definition, field_args, query_context, next_middleware)
    case parent_type
    when MutationType
      current_user = query_context[:current_user]
      case field_definition.name
      when 'createPartner', 'createUser'
      else
        raise 'user is not signed in' if current_user.nil?
      end

      case field_definition.name
      when 'createZiltag'
      when 'updateZiltag', 'deleteZiltag'
        ziltag = Ziltag.find_by! natural_id: field_args[:id]
        raise "Ziltag '#{ziltag.natural_id}' is not writable for the user '#{current_user.username}'" if ziltag.user_id != current_user.id
      when 'updateComment', 'deleteComment'
        comment = Comment.find field_args[:id]
        raise "Comment ##{comment.id} is not writable for the user '#{current_user.username}'" if comment.user_id != current_user.id
      end
    end
    next_middleware.call
  end
end
