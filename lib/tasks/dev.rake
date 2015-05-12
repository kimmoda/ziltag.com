$: << __dir__
require 'dev_task_helper'

namespace :dev do
  DONE = '完成'.freeze
  Rake::TaskManager.record_task_metadata = true

  desc '佈置開發環境'
  task setup: %i[db:setup fake:all]

  namespace :fake do
    desc '產生假資料'
    task all: %i[posts comments child_comments rectangle_photos]

    desc '清空圖片'
    task clear_uploads: :environment do |t|
      puts "# #{t.comment}"
      rm_rf File.join(CarrierWave.root, 'uploads')
    end

    desc '載入圖片'
    task :images do
      @images = Dir[Rails.root.join('test/fixtures/images/*')].map!{|path| File.open(path)}
    end

    desc '產生會員資料'
    task users: %i[db:setup clear_uploads images] do |t|
      print t.comment
      @users = []
      10.times do |i|
        user = User.new(email: Faker::Internet.safe_email, username: Faker::Internet.user_name, password: 'password', avatar: @images.sample)
        user.skip_confirmation!
        user.save!
        @users << user
        dot
      end
      done
    end

    desc '產生圖片'
    task photos: :users do |t|
      print t.comment
      @photos = []
      @users.each do |user|
        2.times do |i|
          @photos << user.photos.create!(title: "標題 #{user.id}-#{i}", image: @images.sample)
          dot
        end
      end
      done
    end

    desc '產生樂貼'
    task posts: :photos do |t|
      print t.comment
      @posts = []
      @users.each do |user|
        user.photos.each_with_index do |photo, i|
          post = user.posts.create!(
            title: Faker::Lorem.sentence,
            content: Faker::Lorem.paragraphs(3).map!{|x| "<p>#{x}</p><img src=\"http://placehold.it/100x100\">"}.join
          )
          @posts << post
          Ziltagging.create!(
            image_url: photo.image_url,
            post: post, x: rand(200), y: rand(200)
          )
          dot
        end
      end
      done
    end

    desc '會員加貼'
    task comments: %i[users photos] do |t|
      print '會員加貼圖片'
      @comments = []
      @users.each do |user|
        @photos.each do |photo|
          @comments << user.comments.create!(
            x: rand(200), y: rand(200), text: '一句話',
            image_url: photo.image_url
          )
          dot
        end
      end
      done
    end

    desc '會員加貼他人的貼'
    task child_comments: %i[users comments] do |t|
      print t.comment
      @comments.each do |comment|
        @users.sample.comments.create!(
          x: rand(200), y: rand(200), text: '回覆一句話', root: comment,
          image_url: comment.image_url
        )
        dot
      end
      done
    end # task

    desc '產生 10 張長寬不一的樂貼'
    task rectangle_photos: %i[users] do |t|
      print t.comment
      file_400x200 = File.open(Rails.root.join('test/fixtures/images/400x200.jpg'))
      file_200x400 = File.open(Rails.root.join('test/fixtures/images/200x400.jpg'))
      user = User.last
      photo_400x200 = user.photos.create! title: '400x200', image: file_400x200
      photo_200x400 = user.photos.create! title: '200x400', image: file_200x400

      post = user.posts.create!(title: Faker::Lorem.sentence, content: Faker::Lorem.paragraphs(3).map!{|x| "<p>#{x}</p><img src=\"http://placehold.it/100x100\">"}.join)
      Ziltagging.create! image_url: photo_400x200.image_url, post: post, x: 10, y: 10; dot
      Ziltagging.create! image_url: photo_400x200.image_url, post: post, x: 10, y: 190; dot
      Ziltagging.create! image_url: photo_400x200.image_url, post: post, x: 390, y: 190; dot
      Ziltagging.create! image_url: photo_400x200.image_url, post: post, x: 390, y: 10; dot
      Ziltagging.create! image_url: photo_400x200.image_url, post: post, x: 100 + rand(300), y: rand(200); dot

      Ziltagging.create! image_url: photo_200x400.image_url, post: post, x: 10, y: 10; dot
      Ziltagging.create! image_url: photo_200x400.image_url, post: post, x: 10, y: 390; dot
      Ziltagging.create! image_url: photo_200x400.image_url, post: post, x: 190, y: 390; dot
      Ziltagging.create! image_url: photo_200x400.image_url, post: post, x: 190, y: 10; dot
      Ziltagging.create! image_url: photo_200x400.image_url, post: post, x: rand(200), y: 100 + rand(300); dot
      done
    end

  end # namespace :fake
end unless Rails.env.production?