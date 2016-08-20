# frozen_string_literal: true
if Rails.env.development?
  Rack::MiniProfiler.config.skip_paths << '/uploads' << '/images' << '/favicon.png' << '/embedded' << '/rails'
end
