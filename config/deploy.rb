# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'ziltag'
set :repo_url, 'git@github.com:ziltag/ziltag.com.git'
set :ssh_options, {forward_agent: true, keys: %w[~/.ssh/ziltag]}
set :deploy_to, '/home/deploy/ziltag'
set :linked_files, fetch(:linked_files, []).push('config/application.yml', 'config/database.yml', 'config/secrets.yml', 'config/puma.rb')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :keep_releases, 2

namespace :deploy do
  after :updated, :webpack do
    on roles(:app) do
      within release_path do
        with webpack_env: :production do
          execute :npm, 'run build'
        end
      end
    end
  end

  after :publishing, :restart do
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
