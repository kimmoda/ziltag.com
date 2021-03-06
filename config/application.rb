# frozen_string_literal: true
require File.expand_path('../boot', __FILE__)

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ZiltagApp
  class Application < Rails::Application
    require 'English'
    require 'ziltag_app/middlewares/db_logger'
    config.middleware.use Middlewares::DBLogger
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Taipei'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.fallbacks = %i(en)
    config.i18n.default_locale = :'en-US'
    config.i18n.available_locales = %i(en-US zh-TW en zh ja ja-JP)

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.generators do |g|
      g.assets = false
      g.helper = false
      g.jbuilder = false
      g.test_framework = false
      g.skip_routes = true
    end

    config.active_job.queue_adapter = :queue_classic
    config.active_record.schema_format = :sql
    config.action_view.field_error_proc = proc do |html_tag, _instance|
      html_tag
    end

    config.autoload_paths << Rails.root.join('app', 'graph', 'types') << Rails.root.join('app', 'graph', 'middlewares')
    config.log_level = :debug
    config.log_tags  = [:subdomain, :uuid]
    config.logger    = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))
  end
end
