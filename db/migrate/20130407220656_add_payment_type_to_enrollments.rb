class AddPaymentTypeToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :payment_type, :string
  end
end
