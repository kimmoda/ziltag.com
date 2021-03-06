# frozen_string_literal: true
require 'execjs'
class PagesController < ApplicationController
  before_action :allow_iframe, :set_state

  def home
    lang = http_accept_language.compatible_language_from(I18n.available_locales)
    @html = nil
    @state.merge! lang: lang, isSignedIn: user_signed_in?, isMobile: mobile?
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
    render :home
  end

  def m_demo
    if shorten_url = ShortenUrl.find_by(natural_id: params[:preview])
      @state.merge! demo: {name: shorten_url.display_name}
    end
    home
  end

  def preview
    if shorten_url = ShortenUrl.find_by(natural_id: params[:id])
      if mobile?
        redirect_to "/m/demo?preview=#{shorten_url.natural_id}"
      else
        @state.merge! demo: {
          url: shorten_url.url,
          loading: true,
          step: 1,
          tip: true,
          name: shorten_url.display_name
        }, modal: {
          name: 'demoGreeting',
          size: 'small',
          showClose: false,
          overlayClose: false
        }
        home
      end
    else
      redirect_to root_path
    end
  end

  private

  def render_jsx(initState)
    context.eval("renderApp(#{request.original_fullpath.to_json}, #{initState.to_json})")
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

  def set_state
    @state ||= {}
  end

  def allow_iframe
    response.headers.delete 'X-Frame-Options'
  end
end
