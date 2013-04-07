class SwapOrderAndTimeFromPanelsAndTalks < ActiveRecord::Migration
  def up
  	add_column :panels, :order, :integer
  	remove_column :panels, :starts_at
  	
  	add_column :talks, :starts_at, :time
  	remove_column :talks, :order
  end

  def down
  end
end
