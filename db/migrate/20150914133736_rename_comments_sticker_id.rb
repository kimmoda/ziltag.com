class RenameCommentsStickerId < ActiveRecord::Migration
  def change
    rename_column :comments, :sticker_id, :ziltag_id
  end
end
