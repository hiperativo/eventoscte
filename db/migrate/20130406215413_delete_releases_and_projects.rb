class DeleteReleasesAndProjects < ActiveRecord::Migration
  def up
  	drop_table :releases
  	drop_table :projects

  end

  def down
  end
end
