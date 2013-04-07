class AddAdditionalInfoToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :additional_info, :text
  end
end
