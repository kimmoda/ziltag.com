require_relative 'middlewares/authorization_middleware'

ZiltagSchema = GraphQL::Schema.new(query: QueryType, mutation: MutationType)
# ZiltagSchema.middleware << AuthorizationMiddleware.new