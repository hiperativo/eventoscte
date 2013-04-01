class ChangeAfterAndBeforeToTexto < ActiveRecord::Migration
  def up
  	change_column :events, :after, :text
  	change_column :events, :before, :text
  end

  def down
  end
end
