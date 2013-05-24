class RenameOrderToOrdem < ActiveRecord::Migration
  def up
  	rename_column :talks, :order, :ordem
  end

  def down
  end
end
