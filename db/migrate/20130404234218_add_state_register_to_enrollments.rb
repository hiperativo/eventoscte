class AddStateRegisterToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :state_register, :string
  end
end
