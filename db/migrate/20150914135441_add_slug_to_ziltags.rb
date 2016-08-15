# frozen_string_literal: true
class AddSlugToZiltags < ActiveRecord::Migration
  def change
    add_column :ziltags, :slug, :string
    add_index :ziltags, :slug

    reversible do |dir|
      dir.up do
        Ziltag.find_each do |ziltag|
          ziltag.generate_slug if ziltag.slug.blank?
          ziltag.save!
        end
      end
    end

    change_column_null :ziltags, :slug, false
  end
end
