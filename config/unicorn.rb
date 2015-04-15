APP_ROOT = '/var/www/ziltag'
worker_processes 4
user 'deploy'
working_directory "#{APP_ROOT}/current"
listen "#{APP_ROOT}/shared/tmp/sockets/.unicorn.sock", :backlog => 64
# listen 8080, :tcp_nopush => true
timeout 30
pid "#{APP_ROOT}/shared/tmp/pids/unicorn.pid"

stderr_path "#{APP_ROOT}/shared/log/unicorn.stderr.log"
stdout_path "#{APP_ROOT}/shared/log/unicorn.stdout.log"

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and GC.copy_on_write_friendly = true

check_client_connection false

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end