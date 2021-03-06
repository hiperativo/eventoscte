class Event < ActiveRecord::Base
	attr_accessible :address, :banner, :banner_cache, 
	:remove_banner, :contact_info, :description, :lead, 
	:place, :target, :title, :date, :after, :before, :slug, 
	:disabled, :release, :release_cache, :remove_release
	mount_uploader :release, ReleaseUploader
	# has_and_belongs_to_many :speakers
	has_many :panels
	has_many :talks, through: :panels
	has_many :speakers, through: :talks
	has_many :enrollments
	has_many :videos
	has_many :photos
	has_many :interviews

	attr_accessible :panel_ids
	attr_accessible :speaker_ids
	accepts_nested_attributes_for :speakers

	default_scope order("date ASC")

	mount_uploader :banner, EventCoverUploader

	attr_accessor :stuff_before, :stuff_after, :has_passed

	before_save :create_slug


	def has_passed
		Time.now > self.date + 1.day
		# self.date < Time.new(2013, 6)
	end

	def before_or_after
		self.has_passed ? :after : :before
	end

	def create_slug
		self.slug = self.title.parameterize
	end

	def stuff_before
		self.split_stuff_that_happens :before
	end

	def stuff_after 
		self.split_stuff_that_happens :after
	end

	def split_stuff_that_happens what
		self[what].split("\n").map do |item|
			{ time: item.split(" - ")[0], what: item.split(" - ")[1] }
		end
	end

	def to_param
		"#{self.id}-#{self.title}".parameterize()
	end

	rails_admin do
		field :title
		field :lead
		field :banner
		field :description
		field :date
		field :place
		field :address
		field :target
		field :contact_info
		field :before
		field :after
		field :disabled
		field :slug
		field :release
		field :panels
	end
end
