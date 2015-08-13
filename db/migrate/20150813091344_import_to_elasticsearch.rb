class ImportToElasticsearch < ActiveRecord::Migration
  def change
    Ziltagging.includes(post: :tags).import
    Post.includes(:tags).import
  end
end
