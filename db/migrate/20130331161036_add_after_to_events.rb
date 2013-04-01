class AddAfterToEvents < ActiveRecord::Migration
  def change
    add_column :events, :after, :string
  end
end
