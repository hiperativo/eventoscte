class CreateEventos < ActiveRecord::Migration
  def change
    create_table :eventos do |t|
      t.string :title
      t.string :lead
      t.string :banner
      t.text :description
      t.datetime :when
      t.string :place
      t.string :address
      t.text :target
      t.string :contact_info

      t.timestamps
    end
  end
end
