class RenameSlugToNaturalId < ActiveRecord::Migration
  def change
    rename_column :photos, :natural_id, :natural_id
    rename_column :ziltags, :natural_id, :natural_id
  end
end
