namespace 'dev:fake' do
  desc '產生假資料'
  task all: %i[hook_activerecord clear_uploads load_images] do
    fakeup '產生會員資料' do
      @users = []
      10.times do |i|
        user = User.new(email: Faker::Internet.safe_email, username: Faker::Internet.user_name, password: 'password', avatar: @images.sample)
        user.skip_confirmation!
        user.save!
        @users << user
      end
    end

    fakeup '產生圖片' do
      @photos = []
      @users.each do |user|
        @photos << user.photos.create!(image: @images.sample)
      end
    end

    fakeup '產生樂貼' do
      @posts = []
      @photos.each do |photo|
        post = photo.user.posts.create!(
          title: Faker::Lorem.sentence,
          content: Faker::Lorem.paragraphs(3).map!{|x| "<p>#{x}</p><img src=\"http://placehold.it/100x100\">"}.join,
        )
        @posts << post
        photo.ziltaggings.create!(
          x: rand(200), y: rand(200), post: post
        )
      end
    end

    fakeup '產生加貼' do
      @comments = []
      @users.each do |user|
        @photos.each do |photo|
          @comments << user.comments.create!(
            x: rand(200), y: rand(200), text: Faker::Lorem.sentence,
            image_url: photo.image_url
          )
        end
      end

      @comments.each do |comment|
        @users.sample.comments.create!(
          x: rand(200), y: rand(200), text: Faker::Lorem.sentence , root: comment,
          image_url: comment.image_url
        )
      end
    end

    fakeup '在第一個樂貼的圖上產生 10 個額外的樂貼' do
      photo = Ziltagging.find(1).photo
      10.times do
        photo.ziltaggings.create!(
          x: rand(200), y: rand(200),
          post: @posts.sample
        )
      end
    end

    fakeup '產生 10 張長寬不一的樂貼' do
      file_400x200 = File.open(Rails.root.join('test/fixtures/images/400x200.jpg'))
      file_200x400 = File.open(Rails.root.join('test/fixtures/images/200x400.jpg'))
      user = User.last
      photo_400x200 = user.photos.create! image: file_400x200
      photo_200x400 = user.photos.create! image: file_200x400

      post = user.posts.create!(title: Faker::Lorem.sentence, content: Faker::Lorem.paragraphs(3).map!{|x| "<p>#{x}</p><img src=\"http://placehold.it/100x100\">"}.join)
      Ziltagging.create! photo: photo_400x200, post: post, x: 10, y: 10
      Ziltagging.create! photo: photo_400x200, post: post, x: 10, y: 190
      Ziltagging.create! photo: photo_400x200, post: post, x: 390, y: 190
      Ziltagging.create! photo: photo_400x200, post: post, x: 390, y: 10
      Ziltagging.create! photo: photo_400x200, post: post, x: 100 + rand(300), y: rand(200)

      Ziltagging.create! photo: photo_200x400, post: post, x: 10, y: 10
      Ziltagging.create! photo: photo_200x400, post: post, x: 10, y: 390
      Ziltagging.create! photo: photo_200x400, post: post, x: 190, y: 390
      Ziltagging.create! photo: photo_200x400, post: post, x: 190, y: 10
      Ziltagging.create! photo: photo_200x400, post: post, x: rand(200), y: 100 + rand(300)
    end

    fakeup '產生追蹤' do
      User.find_each do |follower|
        @users.sample(2).each{ |leader| Following.create follower: follower, leader: leader }
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