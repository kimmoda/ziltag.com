ZiltagSchema = GraphQL::Schema.new(query: QueryType, mutation: MutationType)
ZiltagSchema.rescue_from(Exception){|err| err.message}
ZiltagSchema.middleware << AuthorizationMiddleware.new
