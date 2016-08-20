# frozen_string_literal: true
class RenamePhotosPath < ActiveRecord::Migration
  def change
    rename_column :photos, :path, :href
  end
end
