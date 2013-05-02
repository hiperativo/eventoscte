class Video < ActiveRecord::Base
  attr_accessible :youtube_code, :event_id
  belongs_to :video
end
