# frozen_string_literal: true
class CreateSseNotifications < ActiveRecord::Migration
  def change
    create_table :sse_notifications do |t|
      t.json :body, null: false
      t.timestamps null: false
    end
  end
end
