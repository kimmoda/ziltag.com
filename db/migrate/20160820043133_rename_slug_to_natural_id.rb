class RenameSlugToNaturalId < ActiveRecord::Migration
  def change
    rename_column :photos, :slug, :natural_id
    rename_column :ziltags, :slug, :natural_id
  end
end
