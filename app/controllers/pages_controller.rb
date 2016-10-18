# frozen_string_literal: true
require 'execjs'
class PagesController < ApplicationController
  def home
    lang = http_accept_language.compatible_language_from(I18n.available_locales)
    @html = nil
    @state = {lang: lang}
    result = render_jsx(@state)
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

  def render_jsx(initState)
    context.eval("renderApp(#{request.path.to_json}, #{initState.to_json})")
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
