class AddStartsAtToPanels < ActiveRecord::Migration
  def change
    add_column :panels, :starts_at, :time
  end
end
