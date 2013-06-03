class AddMateriaLinkToReleases < ActiveRecord::Migration
  def change
    add_column :clippings, :materia_link, :string
  end
end
