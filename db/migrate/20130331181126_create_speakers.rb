class CreateSpeakers < ActiveRecord::Migration
  def change
    create_table :speakers do |t|
      t.string :name
      t.string :ocupation
      t.text :bio
      t.string :avatar

      t.timestamps
    end
  end
end
