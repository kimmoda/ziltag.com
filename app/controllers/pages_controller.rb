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
    context.eval("renderApp(#{request.path.to_json})")
  end

  def context
    if Rails.env.production?
      @@_js_context ||= load_context
    else
      load_context
    end
  end

  def load_context
    path = Rails.root.join('lib', 'server.js')
    ExecJS.compile(File.read(path))
  end
end
