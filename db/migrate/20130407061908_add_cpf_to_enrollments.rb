class AddCpfToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :cpf, :string
  end
end
