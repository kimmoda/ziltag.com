class AdminController < ApplicationController
  http_basic_authenticate_with Settings.http_basic_authentication.symbolize_keys unless Rails.env.development?
end
