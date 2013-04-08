class AddContentsToInterviews < ActiveRecord::Migration
  def change
    add_column :interviews, :contents, :text
  end
end
