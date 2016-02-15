# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'ziltag'
set :repo_url, 'git@github.com:ziltag/ziltag.com.git'
set :ssh_options, {forward_agent: true, keys: %w[~/.ssh/ziltag]}
set :deploy_to, '/home/deploy/ziltag'
set :linked_files, fetch(:linked_files, []).push('config/application.yml', 'config/database.yml', 'config/secrets.yml', 'config/puma.rb')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'node_modules')

namespace :deploy do
  after :updated, :webpack
  after :publishing, :restart

  after :webpack do
    on roles(:web) do
      within release_path do
        with webpack_env: :production do
          execute release_path.join('node_modules/.bin/webpack')
        end
      end
    end
  end

  task :restart do
    on roles(:app) do
      execute :sudo, '/etc/init.d/puma', 'phased-restart'
    end
    on roles(:worker) do
      execute :sudo, '/etc/init.d/qc', 'restart'
    end
    on roles(:sse) do
      execute :sudo, '/etc/init.d/sse', 'restart'
    end
  end
end
