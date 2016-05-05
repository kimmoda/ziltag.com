ZiltagSchema = GraphQL::Schema.new(query: QueryType, mutation: MutationType)
ZiltagSchema.rescue_from(Exception){ |err| asdfasdf }
ZiltagSchema.middleware << AuthorizationMiddleware.new
