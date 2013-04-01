class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.string :order
      t.string :title
      t.string :speaker_id

      t.timestamps
    end
  end
end
