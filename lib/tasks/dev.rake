$: << __dir__
require 'dev_task_helper'

namespace :dev do
  DONE = '完成'.freeze
  Rake::TaskManager.record_task_metadata = true

  desc '佈置開發環境'
  task setup: %i[db:setup fake:all]

  namespace :fake do
    desc '產生假資料'
    task all: %i[users photos posts comments child_comments]

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
        @users << User.create!(email: "user_#{i}@example.com", password: 'password', avatar: @images.sample)
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
          post = user.posts.create!(title: "標題 #{user.id}-#{i}", content: "<p>內文</p><p>內文</p><p>內文</p>")
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
  end # namespace :fake
end unless Rails.env.production?