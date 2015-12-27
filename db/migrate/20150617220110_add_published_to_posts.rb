class AddPublishedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :published, :boolean, null: false, default: false
    reversible do |dir|
      dir.up{ Post.find_each{ |post| post.update_columns published: true } }
    end if Object.const_defined? :Post
  end
end
