# frozen_string_literal: true
MutationType = GraphQL::ObjectType.define do
  name 'Mutation'
  description 'The mutation root'

  field :uploadAvatar, UserType do
    resolve -> (_obj, _args, ctx) do
      current_user = ctx[:current_user]
      file = ctx[:file]
      if current_user.update avatar: ctx[:file]
        current_user
      else
        raise GraphQL::ExecutionError, current_user.errors.messages.values.first.first
      end
    end
  end

  field :createPartner, UserType do
    argument :username, !types.String
    argument :email, !types.String
    argument :url, !types.String
    resolve -> (_obj, args, ctx) do
      partner_sign_up = PartnerSignUp.perform(args[:username], args[:email], args[:url])
      if partner_sign_up.success?
        partner_sign_up.user
        ctx[:warden].set_user(partner_sign_up.user, scope: :user)
      else
        raise GraphQL::ExecutionError, partner_sign_up.error
      end
    end
  end

  field :createUser, UserType do
    argument :username, !types.String
    argument :email, !types.String
    resolve -> (_obj, args, _ctx) do
      user_sign_up = UserSignUp.perform(args[:username], args[:email])
      if user_sign_up.success?
        user_sign_up.user
      else
        raise GraphQL::ExecutionError, user_sign_up.error
      end
    end
  end

  field :updateUser, UserType do
    argument :old_password, !types.String
    argument :new_password, !types.String
    argument :confirm_password, !types.String
    resolve -> (_obj, args, ctx) do
      ctx[:current_user].update_with_password(
        current_password: args[:old_password],
        password: args[:new_password],
        password_confirmation: args[:confirm_password]
      )
      if ctx[:current_user].errors.empty?
        ctx[:warden].set_user(ctx[:current_user], scope: :user)
        ctx[:current_user]
      else
        raise GraphQL::ExecutionError, ctx[:current_user].errors.messages.values.first.first
      end
    end
  end

  field :createZiltag, ZiltagType do
    argument :x, !types.Float
    argument :y, !types.Float
    argument :content, !types.String
    argument :map_id, !types.ID
    resolve -> (_obj, args, ctx) do
      create_ziltag = CreateZiltag.perform(ctx[:current_user], args[:map_id], args[:x], args[:y], args[:content])
      if create_ziltag.success?
        create_ziltag.ziltag
      else
        raise GraphQL::ExecutionError, create_ziltag.error
      end
    end
  end

  field :updateZiltag, ZiltagType do
    argument :id, !types.ID, 'Ziltag ID'
    argument :content, !types.String
    resolve -> (_obj, args, _ctx) do
      ziltag = Ziltag.find_by!(natural_id: args[:id])
      if ziltag.update(content: args[:content])
        ziltag
      else
        raise GraphQL::ExecutionError, ziltag.errors.full_messages.first
      end
    end
  end

  field :deleteZiltag, ZiltagType do
    argument :id, !types.ID, 'Ziltag ID'
    resolve -> (_obj, args, _ctx) do
      ziltag = Ziltag.find_by! natural_id: args[:id]
      ziltag.destroy
      ziltag
    end
  end

  field :createComment, CommentType do
    argument :ziltag_id, !types.ID
    argument :content, !types.String
    resolve -> (_obj, args, ctx) do
      ziltag = Ziltag.find_by! natural_id: args[:ziltag_id]
      create_comment = CreateComment.perform(ctx[:current_user], content: args[:content], ziltag: ziltag)
      if create_comment.success?
        create_comment.comment
      else
        raise GraphQL::ExecutionError, create_comment.error
      end
    end
  end

  field :updateComment, CommentType do
    argument :id, !types.ID
    argument :content, !types.String
    resolve -> (_obj, args, _ctx) do
      comment = Comment.find(args[:id])
      if comment.update(content: args[:content])
        comment
      else
        raise GraphQL::ExecutionError, comment.errors.full_messages.first
      end
    end
  end

  field :deleteComment, CommentType do
    argument :id, !types.ID
    resolve -> (_obj, args, _ctx) do
      comment = Comment.find(args[:id])
      comment.destroy
      comment
    end
  end

  field :createWebsite, WebsiteType do
    argument :url, !types.String
    resolve -> (_obj, args, ctx) do
      current_user = ctx[:current_user]
      url = args[:url]
      website = current_user.websites.create url: url
      if website.persisted?
        website
      else
        raise GraphQL::ExecutionError, website.errors.full_messages.first
      end
    end
  end

  field :deleteWebsite, WebsiteType do
    argument :id, !types.ID
    resolve -> (_obj, args, _ctx) do
      website = Website.find(args[:id])
      website.destroy
      website
    end
  end

  field :updateWebsite, WebsiteType do
    argument :id, !types.ID
    argument :url, types.String
    resolve -> (_obj, args, _ctx) do
      website = Website.find(args[:id])
      if website.update url: args[:url]
        website
      else
        raise GraphQL::ExecutionError, website.errors.full_messages.first
      end
    end
  end

  field :upgradeUser, UserType do
    argument :url, !types.String
    resolve -> (_obj, args, ctx) do
      upgrade_user = UpgradeUser.perform(ctx[:current_user], args[:url])
      if upgrade_user.success?
        upgrade_user.user
      else
        raise GraphQL::ExecutionError, upgrade_user.error
      end
    end
  end

  field :updateWebsitePermission, WebsiteType do
    argument :id, !types.ID
    argument :restricted, types.Boolean
    resolve -> (_obj, args, _ctx) do
      website = Website.find(args[:id])
      website.update_column :restricted, args[:restricted]
      website
    end
  end

  field :updateZiltagNotification, UserType do
    argument :ziltagNotification, !types.Boolean
    resolve -> (_obj, args, ctx) do
      ctx[:current_user].update_column :ziltag_notification, args[:ziltagNotification]
      ctx[:current_user]
    end
  end

  field :updateCommentNotification, UserType do
    argument :commentNotification, !types.Boolean
    resolve -> (_obj, args, ctx) do
      ctx[:current_user].update_column :comment_notification, args[:commentNotification]
      ctx[:current_user]
    end
  end

  field :createShortenURL, ShortenURLType do
    argument :url, !types.String
    resolve ->(obj, args, ctx) do
      ShortenUrl.create url: args[:url]
    end
  end
end
