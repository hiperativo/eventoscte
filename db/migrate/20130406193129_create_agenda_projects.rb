class CreateAgendaProjects < ActiveRecord::Migration
  def change
    create_table :agenda_projects do |t|
      t.string :title
      t.string :synopsis
      t.string :contents

      t.timestamps
    end
  end
end
