class Project
  include Mongoid::Document
  include Mongoid::Revisions

	revisions :exclude=>[:contributors]

  field :name  

  has_many :milestones
	belongs_to :user
	has_many :contributors
	has_one :configuration
  embeds_many :notes
	embeds_one :version
	has_and_belongs_to_many :teams
end
