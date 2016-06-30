# frozen_string_literal: true
api_key = if Rails.env.production?
            Settings.mandrill.api_key
          else
            'lhm7dDsYZOgYMQ-wyfqfHA'
          end

MANDRILL_CLIENT = Mandrill::API.new api_key
