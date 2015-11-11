# Be sure to restart your server when you modify this file.

if Rails.env.production?
  Rails.application.config.session_store :cookie_store, key: '_ziltag_session', domain: ".#{Settings.host}"
else
  Rails.application.config.session_store :cookie_store, key: '_ziltag_session'
end
