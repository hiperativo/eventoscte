class AddOrderToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :order, :integer
  end
end
