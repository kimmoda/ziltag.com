source 'https://rubygems.org'

gem 'rails', '4.2.1'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'settingslogic'

gem 'unicorn'
gem 'devise'
gem 'devise-i18n'
gem 'simple_form'
gem 'kaminari'
gem 'rails-i18n'
gem 'carrierwave'
gem 'mini_magick'
# TODO: This should be removed after capistrano-rails is ready for sprockets 3
# https://github.com/capistrano/rails/issues/33
# https://github.com/rails/sprockets-rails/issues/229
gem 'sprockets', '2.12.3'
gem 'fog'

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap'
  gem 'rails-assets-select2', '~> 4.0.0.rc.2'
  # TODO: Wait for bower registraion
  # ref https://github.com/fk/select2-bootstrap-theme/issues/1
  # gem 'select2-bootstrap-theme'
end

group :development do
  gem 'capistrano'
  gem 'capistrano-rails'
end

group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

