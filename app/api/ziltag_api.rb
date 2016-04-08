class ZiltagAPI < Grape::API
  error_formatter :json, ->(message, backtrace, options, env) {
    {errors: [{message: message}]}.to_json
  }

  rescue_from Grape::Exceptions::ValidationErrors do |e, b|
    headers = {
      'Access-Control-Allow-Credentials' => 'true',
      'Access-Control-Allow-Origin' => env['HTTP_ORIGIN'] || '*'
    }
    error! e.full_messages.first, 200, headers
  end

  before do
    header 'Access-Control-Allow-Credentials', 'true'
    header 'Access-Control-Allow-Origin', request.headers['Origin'] || '*'
    header 'Access-Control-Allow-Headers', 'Origin, Content-Type, Accept, Authorization, Token'
  end

  mount V2
end