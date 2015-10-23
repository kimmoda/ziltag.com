class AddShareImageToZiltags < ActiveRecord::Migration
  def change
    add_column :ziltags, :share_image, :string
  end
end
