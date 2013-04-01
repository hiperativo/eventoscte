class ChangeSpeakerIdToIntegerInTalks < ActiveRecord::Migration
  def up
  	remove_column :talks, :speaker_id
  	add_column :talks, :speaker_id, :integer
  end

  def down
  end
end
