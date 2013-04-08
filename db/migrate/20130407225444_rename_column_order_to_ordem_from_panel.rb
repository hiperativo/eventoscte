class RenameColumnOrderToOrdemFromPanel < ActiveRecord::Migration
  def up
  	rename_column :panels, :order, :ordem
  end

  def down
  end
end
