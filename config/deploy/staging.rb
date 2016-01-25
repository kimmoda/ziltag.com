set :rails_env, 'production'
set :branch, :dev
server 'staging.ziltag.com', user: 'deploy', roles: %w{app db worker sse}