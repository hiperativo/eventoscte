class AddDisabledToEvents < ActiveRecord::Migration
  def change
    add_column :events, :disabled, :boolean, default: false
  end
end
