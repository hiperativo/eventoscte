class AddGroupEnrollmentToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :group_enrollment, :boolean
  end
end
