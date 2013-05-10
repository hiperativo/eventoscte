class AddImageToClippings < ActiveRecord::Migration
  def change
    add_column :clippings, :image, :string
  end
end
