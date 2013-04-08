class AddPriceToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :price, :string
  end
end
