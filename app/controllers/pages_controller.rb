# frozen_string_literal: true
require 'execjs'
class PagesController < ApplicationController
  def home
    @html = nil
    @state = {}
    result = render_jsx
    case result['status']
    when 500 then head 500
    when 302
      redirect_to result['location'].pathname + result['location'].search
    when 404 then head 404
    when 200
      @html = result['body']
      @state = result['state']
    end
  end

  private

  def render_jsx
    context.exec <<~EOS
      var store = Store.getStore()
      var error, redirectLocation, renderProps

      ReactRouter.match({routes: Routes.getRoutes(), location: '/'}, function(_error, _redirectLocation, _renderProps){
        error = _error
        redirectLocation = _redirectLocation
        renderProps = _renderProps
      })
      var ret
      if (error) {
        return { status: 500, error: error }
      } else if (redirectLocation) {
        return {status: 302, location: redirectLocation}
      } else if (renderProps) {
        return {
          status: 200,
          body: ReactDOMServer.renderToString(
            React.createElement(
              ReactRedux.Provider, { store: store }, React.createElement(ReactRouter.RouterContext, renderProps)
            )
          ),
          state: store.getState()
        }
      } else {
        return {
          status: 404
        }
      }
    EOS
  end

  def context
    path = Rails.root.join('public' + WebpackStats.assets['landing_server.js'])
    ExecJS.compile(File.read(path))
  end
end
