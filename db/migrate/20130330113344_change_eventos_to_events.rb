class ChangeEventosToEvents < ActiveRecord::Migration
  def up
  	rename_table :eventos, :events
  end

  def down
  	rename_table :events, :eventos
  end
end
