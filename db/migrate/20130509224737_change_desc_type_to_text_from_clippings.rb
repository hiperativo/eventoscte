class ChangeDescTypeToTextFromClippings < ActiveRecord::Migration
  def up
  	change_column :clippings, :desc, :text
  end

  def down
  end
end
