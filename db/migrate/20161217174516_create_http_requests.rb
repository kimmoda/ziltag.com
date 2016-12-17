class CreateHttpRequests < ActiveRecord::Migration
  def change
    create_table :http_requests do |t|
      t.json :env, null: false, default: {}
      t.string :session_id
      t.string :referer
      t.json :params, null: false, default: {}
      t.datetime :created_at, null: false
    end
    add_index :http_requests, :session_id
  end
end
