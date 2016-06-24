# frozen_string_literal: true

api_key = if Rails.env.production?
            Settings.gibbon.api_key
          else
            'fa659b0307d7d58a9c002362b9d2bc36-us13'
          end

Gibbon::Request.api_key = api_key
Gibbon::Request.timeout = 15
