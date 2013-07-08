class Project < ActiveRecord::Base
  attr_accessible :description, :synopsis, :title, :position
end
