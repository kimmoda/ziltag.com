# frozen_string_literal: true
module Admin
  class PartnersController < Admin::ApplicationController
    def order
      if params[:order] && params[:direction]
        super
      else
        Administrate::Order.new(:id, :desc)
      end
    end
  end
end
