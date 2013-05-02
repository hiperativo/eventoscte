class AddEventIdToInterviews < ActiveRecord::Migration
  def change
    add_column :interviews, :event_id, :integer
  end
end
