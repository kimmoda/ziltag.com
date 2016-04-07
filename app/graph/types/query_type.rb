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
    resolve -> (object, arguments, context) {
      Photo.find_by!(slug: arguments['id'])
    }
  end
end