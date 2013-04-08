class CreateInterviews < ActiveRecord::Migration
  def change
    create_table :interviews do |t|
      t.string :title
      t.string :lead
      t.string :synopsis
      t.string :image

      t.timestamps
    end
  end
end
