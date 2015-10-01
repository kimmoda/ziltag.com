set :rails_env, 'production'
set :branch, :dev
set :deploy_to, '/var/www/ziltag'
server 'staging.ziltag.com', user: 'deploy', roles: %w{app db web worker}