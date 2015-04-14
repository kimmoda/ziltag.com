class AdminController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_NAME'], password: ENV['ADMIN_PASSWORD'] unless Rails.env.development?

  def select2_query collection, attribute
    params[:q].present? ? collection.where("#{attribute} ILIKE ?", "%#{params[:q]}%") : collection
  end
end
