# frozen_string_literal: true
class ImportToElasticsearch < ActiveRecord::Migration
  def change
    Ziltagging.includes(post: :tags).import if Object.const_defined? :Ziltagging
    Post.includes(:tags).import if Object.const_defined? :Post
  end
end
