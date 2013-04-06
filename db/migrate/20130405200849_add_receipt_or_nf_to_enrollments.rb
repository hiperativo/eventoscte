class AddReceiptOrNfToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :receipt_or_nf, :string
  end
end
