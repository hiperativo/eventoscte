class CreatePanels < ActiveRecord::Migration
  def change
    create_table :panels do |t|
      t.integer :event_id
      t.string :title
      t.time :starts_at

      t.timestamps
    end
  end
end
