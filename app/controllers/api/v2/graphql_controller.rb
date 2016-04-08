class Api::V2::GraphqlController < ApplicationController
  skip_before_action :verify_authenticity_token
  def execute
    headers['Access-Control-Allow-Credentials'] = 'true'
    headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
    query_string = params[:query]
    query_variables = params[:variables] || {}
    result = ZiltagSchema.execute(query_string, variables: query_variables, context: {current_user: current_user})
    render json: result
  rescue
    headers['Access-Control-Allow-Credentials'] = 'true'
    headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
    Rails.logger.error $!.to_s
    Rails.logger.error $@.join($/)
    render json: {errors: [{message: $!.to_s}]}
  end
end
