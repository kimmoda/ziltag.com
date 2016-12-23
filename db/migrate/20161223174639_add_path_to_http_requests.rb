class AddPathToHttpRequests < ActiveRecord::Migration
  def change
    add_column :http_requests, :path, :string
    reversible do |dir|
      dir.up do
        HTTPRequest.find_each do |request|
          request.update_column :path, request.env['PATH_INFO']
        end
      end
    end
    add_index :http_requests, :path
  end
end
