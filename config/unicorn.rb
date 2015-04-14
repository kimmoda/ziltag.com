APP_ROOT = '/var/www/ziltag'
worker_processes 4
user 'deploy'
working_directory "#{APP_ROOT}/current"
listen "/var/run/.unicorn.sock", :backlog => 64
# listen 8080, :tcp_nopush => true
timeout 30
pid "#{APP_ROOT}/shared/tmp/pids/unicorn.pid"

stderr_path "#{APP_ROOT}/shared/log/unicorn.stderr.log"
stdout_path "#{APP_ROOT}/shared/log/unicorn.stdout.log"

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

check_client_connection false

run_once = true
before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  if run_once
    # do_something_once_here ...
    run_once = false # prevent from firing again
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end