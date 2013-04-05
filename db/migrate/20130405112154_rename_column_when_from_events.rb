class RenameColumnWhenFromEvents < ActiveRecord::Migration
  def up
  	rename_column :events, :when, :date
  end

  def down
  end
end
