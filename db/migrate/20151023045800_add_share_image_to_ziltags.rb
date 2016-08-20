# frozen_string_literal: true
class AddShareImageToZiltags < ActiveRecord::Migration
  def change
    add_column :ziltags, :share_image, :string
  end
end
