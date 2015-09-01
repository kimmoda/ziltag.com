namespace 'dev:fake' do
  desc '產生假資料'
  task all: %i[hook_activerecord clear_uploads load_images] do
    fakeup '產生會員資料' do
      @users = []
      10.times do |i|
        user = User.new(email: Faker::Internet.safe_email, username: Faker::Internet.user_name(nil, ['_']), password: 'password', avatar: @images.sample)
        user.skip_confirmation!
        user.save!
        @users << user
      end
    end

    fakeup '產生圖片' do
      @photos = []
      20.times{ @photos << Photo.create!(image: @images.sample) }
    end

    fakeup '產生貼紙' do
      @photos.each do |photo|
        3.times do
          photo.stickers.create!({
            user: @users.sample,
            x: rand(200), y: rand(200),
            content: Faker::Lorem.paragraph
          })
        end
      end
    end
  end

  task hook_activerecord: :environment do
    class ActiveRecord::Base; after_create do; print :'.' end end
  end

  desc '清空圖片'
  task clear_uploads: :environment do |t|
    puts "# #{t.comment}"
    rm_rf File.join(CarrierWave.root, 'uploads')
  end

  desc '載入圖片'
  task :load_images do
    @images = Dir[Rails.root.join('test/fixtures/images/*')].map!{|path| File.open(path)}
  end

end unless Rails.env.production?