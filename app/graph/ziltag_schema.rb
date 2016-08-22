# frozen_string_literal: true
ZiltagSchema = GraphQL::Schema.new(query: QueryType, mutation: MutationType)
ZiltagSchema.middleware << AuthorizationMiddleware.new
