class RemoveAfterFromPanel < ActiveRecord::Migration
  def up
    remove_column :panels, :after
  end

  def down
    add_column :panels, :after, :text
  end
end
