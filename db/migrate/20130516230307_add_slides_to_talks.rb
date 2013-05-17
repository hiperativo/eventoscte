class AddSlidesToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :slides, :string
  end
end
