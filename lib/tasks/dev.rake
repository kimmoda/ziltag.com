# frozen_string_literal: true
$LOAD_PATH << __dir__
require 'dev_task_helper'

namespace :dev do
  desc '佈置開發環境'
  task setup: %i(db:reset fake:all qc:drop qc:create)
end unless Rails.env.production?
