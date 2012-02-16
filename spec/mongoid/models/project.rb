class Project
  include Mongoid::Document
  include Mongoid::Revisions

  field :name  

  has_many :milestones
	belongs_to :user
	has_one :configuration
  embeds_many :notes
	embeds_one :version
	has_and_belongs_to_many :teams
end
