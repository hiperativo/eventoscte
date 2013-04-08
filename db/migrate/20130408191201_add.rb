class Add < ActiveRecord::Migration
  def up
  	add_column :enrollments, :full_price, :string
  end

  def down
  end
end
