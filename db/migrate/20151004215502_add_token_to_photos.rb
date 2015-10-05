class AddTokenToPhotos < ActiveRecord::Migration
  def change
    add_reference :photos, :box, index: true, foreign_key: true
  end
end
