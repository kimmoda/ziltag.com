# frozen_string_literal: true
class AddZiltaggableToZiltaggings < ActiveRecord::Migration
  def change
    add_reference :ziltaggings, :ziltaggable, polymorphic: true, index: true

    reversible do |dir|
      Ziltagging.find_each do |ziltagging|
        dir.up { ziltagging.update_columns ziltaggable_id: ziltagging.read_attribute_before_type_cast(:post_id), ziltaggable_type: :Post }
        dir.down { ziltagging.update_columns post_id:  ziltagging.ziltaggable_id }
      end if Object.const_defined? :Ziltagging
      dir.up do
        change_column_null :ziltaggings, :ziltaggable_id, false
        change_column_null :ziltaggings, :ziltaggable_type, false
      end
      dir.down do
        change_column_null :ziltaggings, :post_id, false
        add_foreign_key :ziltaggings, :posts
      end
    end

    remove_reference :ziltaggings, :post, index: true
  end
end
