namespace :dev do
  task setup: %i[db:setup clear_uploads fake_data]

  task fake_data: :clear_uploads do
    images = Dir[Rails.root.join('test/fixtures/images/*')].map!{|path| File.open(path)}

    10.times do |i|
      User.create email: "user_#{i}@example.com", password: 'password', avatar: images.sample
    end

    User.find_each do |user|
      2.times do |i|
        title = "標題 #{user.id}-#{i}"
        photo = user.photos.create title: title, image: images.sample
        post = user.posts.create title: title, content: "<p>內文</p><p>內文</p><p>內文</p>"
        Ziltagging.create photo: photo, post: post, x: rand(200), y: rand(200)
      end
    end

    images.each(&:close)
  end

  task clear_uploads: :environment do
    rm_rf File.join(CarrierWave.root, 'uploads')
  end
end unless Rails.env.production?
