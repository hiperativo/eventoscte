class AddNameToSupporter < ActiveRecord::Migration
  def change
    add_column :supporters, :name, :string
  end
end
