class AddAfterToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :after, :text
  end
end
