namespace :dev do
  task setup: %i[db:setup db:fixtures:load] do
    files = Dir[Rails.root.join('test/fixtures/images/*')].map!{|path| File.open(path)}
    Photo.find_each{|photo| photo.update image: files.sample }
    files.each(&:close)
  end
end
