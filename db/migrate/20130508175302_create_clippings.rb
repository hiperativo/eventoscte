class CreateClippings < ActiveRecord::Migration
  def change
    create_table :clippings do |t|
      t.string :titulo
      t.string :lead
      t.string :desc
      t.string :materia

      t.timestamps
    end
  end
end
