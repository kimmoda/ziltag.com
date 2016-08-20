# frozen_string_literal: true
class RenameContentProviderToPartner < ActiveRecord::Migration
  def change
    User.where(type: 'ContentProvider').update_all(type: 'Partner')
  end
end
