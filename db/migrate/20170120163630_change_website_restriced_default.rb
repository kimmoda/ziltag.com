class ChangeWebsiteRestricedDefault < ActiveRecord::Migration
  def change
    change_column_default(:websites, :restricted, false)
  end
end
