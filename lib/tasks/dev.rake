namespace :dev do
  task setup: %i[db:setup db:fixtures:load fake_images]

  task fake_images: :clear_uploads do
    files = Dir[Rails.root.join('test/fixtures/images/*')].map!{|path| File.open(path)}
    Photo.find_each{|photo| photo.update image: files.sample }
    User.find_each{|user| user.update avatar: files.sample }
    files.each(&:close)
  end

  task clear_uploads: :environment do
    rm_rf File.join(CarrierWave.root, 'uploads')
  end
end
