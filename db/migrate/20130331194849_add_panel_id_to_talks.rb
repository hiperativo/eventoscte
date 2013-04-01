class AddPanelIdToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :panel_id, :integer
  end
end
