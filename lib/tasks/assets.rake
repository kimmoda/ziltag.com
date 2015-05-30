namespace :assets do
  desc '產生沒有後綴 digest 檔名的 embedded.js'
  task embedded: :environment do
    asset = Rails.application.assets['embedded.js']
    asset.write_to Rails.root.join('public', 'assets', asset.logical_path)
  end

end
