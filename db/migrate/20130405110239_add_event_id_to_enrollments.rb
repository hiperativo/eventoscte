class AddEventIdToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :event_id, :integer
  end
end
