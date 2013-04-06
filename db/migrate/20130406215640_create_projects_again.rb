class CreateProjectsAgain < ActiveRecord::Migration
  def up
  	create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :synopsis

      t.timestamps
	  end

  end

  def down
  end
end
