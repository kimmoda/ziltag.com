QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'The query root'

  field :ziltag, ZiltagType, 'Find a ziltag by ID' do
    argument :id, !types.ID
    resolve -> (object, arguments, context) {
      Ziltag.find_by!(slug: arguments['id'])
    }
  end

  field :comment, CommentType, 'Find a comment by ID' do
    argument :id, !types.ID
    resolve -> (object, arguments, context) {
      Comment.find_by!(id: arguments['id'])
    }
  end

  field :ziltag_map, ZiltagMapType, 'Find a ziltag map by ID' do
    argument :id, !types.ID
    resolve -> (obj, args, ctx) {
      Photo.find_by!(slug: args['id'])
    }
  end

  field :find_ziltag_map, ZiltagMapType, 'Find ziltag_map by token, source and href' do
    argument :token, !types.String, 'The plugin token of ziltag partners'
    argument :src, !types.String, 'The image URL'
    argument :href, !types.String, 'The web URL of the page where the image appears'
    argument :width, !types.Int, 'The client width of the image'
    argument :height, !types.Int, 'The client height of the image'
    resolve ->(obj, args, ctx) {
      find_or_create_map = FindOrCreateMap.call(args[:token], args[:src], args[:href], args[:width], args[:height])
      if find_or_create_map.success?
        find_or_create_map[:photo]
      else
        raise find_or_create_map[:error]
      end
    }
  end
end