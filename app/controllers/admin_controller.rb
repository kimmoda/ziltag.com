class AdminController < ApplicationController
  http_basic_authenticate_with Settings.admin.http_basic_authentication.symbolize_keys unless Rails.env.development?

  def select2_query collection, attribute
    params[:q].present? ? collection.where("#{attribute} ILIKE ?", "%#{params[:q]}%") : collection
  end
end
