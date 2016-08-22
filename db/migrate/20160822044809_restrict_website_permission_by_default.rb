class RestrictWebsitePermissionByDefault < ActiveRecord::Migration
  def up
    change_column_default(:websites, :restricted, true)
  end

  def down
    change_column_default(:websites, :restricted, false)
  end
end
