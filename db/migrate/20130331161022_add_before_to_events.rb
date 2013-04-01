class AddBeforeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :before, :string
  end
end
