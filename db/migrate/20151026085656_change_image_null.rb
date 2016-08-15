# frozen_string_literal: true
class ChangeImageNull < ActiveRecord::Migration
  def change
    change_column_null :photos, :image, true
  end
end
