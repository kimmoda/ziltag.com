class AdminController < ApplicationController
  http_basic_authenticate_with Settings.admin.http_basic_authentication.symbolize_keys if Rails.env.production?
end
