Rack::MiniProfiler.config.skip_paths << '/uploads' << '/images' << '/favicon.png' if Rails.env.development?