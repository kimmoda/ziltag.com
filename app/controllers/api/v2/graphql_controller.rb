# frozen_string_literal: true
class Api::V2::GraphqlController < ApplicationController
  skip_before_action :verify_authenticity_token
  def execute
    headers['Access-Control-Allow-Credentials'] = 'true'
    headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
    query_string = params[:query]
    query_variables = params[:variables] || {}
    result = ZiltagSchema.execute(
      query_string,
      variables: query_variables,
      context: {
        current_user: current_user,
        warden: env['warden'],
        file: params[:file]
      }
    )
    render json: result
  rescue
    headers['Access-Control-Allow-Credentials'] = 'true'
    headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
    render json: { errors: [{ message: $ERROR_INFO.to_s}] }
  end
end
