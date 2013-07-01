class AddSlidesLocalFileToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :slides_local_file, :string
  end
end
