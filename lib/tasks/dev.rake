$: << __dir__
require 'dev_task_helper'

namespace :dev do
  desc '佈置開發環境'
  task setup: %i[db:setup fake:all]
end unless Rails.env.production?