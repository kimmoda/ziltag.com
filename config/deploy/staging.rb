set :rails_env, 'production'
server 'staging.ziltag.com', user: 'deploy', roles: %w{app db web}