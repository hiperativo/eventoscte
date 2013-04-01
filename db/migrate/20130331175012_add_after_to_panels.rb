class AddAfterToPanels < ActiveRecord::Migration
  def change
    add_column :panels, :after, :text
  end
end
