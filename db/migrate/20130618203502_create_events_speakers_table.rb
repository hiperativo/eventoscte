class CreateEventsSpeakersTable < ActiveRecord::Migration
  def up
	create_table :events_speakers, id: false do |t|
		t.integer :event_id
		t.integer :speaker_id
	end
  end

  def down
  end
end
