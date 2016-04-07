class Api::V2::GraphqlController < ApplicationController
  skip_before_action :verify_authenticity_token
  def execute
    query_string = params[:query]
    query_variables = params[:variables] || {}
    result = ZiltagSchema.execute(query_string, variables: query_variables)
    render json: result
  end
end
