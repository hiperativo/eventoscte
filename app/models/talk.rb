class Talk < ActiveRecord::Base
	attr_accessible :order, :speaker_id, :title, :panel_id, :additional_info
	belongs_to :speaker
	belongs_to :panel
	
end
