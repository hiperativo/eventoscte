class Project < ActiveRecord::Base
  attr_accessible :description, :synopsis, :title
end
