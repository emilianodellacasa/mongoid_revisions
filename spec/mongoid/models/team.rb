class Team
  include Mongoid::Document
	include Mongoid::Revisions

  field :name

  has_and_belongs_to_many :projects

end
