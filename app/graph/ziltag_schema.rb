# frozen_string_literal: true
ZiltagSchema = GraphQL::Schema.new(query: QueryType, mutation: MutationType)
ZiltagSchema.rescue_from(Exception, &:message)
ZiltagSchema.middleware << AuthorizationMiddleware.new
