set :rails_env, 'production'
set :branch, :dev
set :deploy_to, '/home/deploy/ziltag'
server 'staging.ziltag.com', user: 'deploy', roles: %w{app db worker}