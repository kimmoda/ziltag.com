class RenameStickers < ActiveRecord::Migration
  def change
    rename_table 'stickers', 'ziltags'
  end
end
