class CreateReleases < ActiveRecord::Migration
  def change
    create_table :releases do |t|
      t.string :title
      t.string :lead
      t.string :image
      t.string :contents

      t.timestamps
    end
  end
end
