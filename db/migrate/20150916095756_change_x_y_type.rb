class ChangeXYType < ActiveRecord::Migration
  def change
    change_column :ziltags, :x, :decimal
    change_column :ziltags, :y, :decimal
  end
end
