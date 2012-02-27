class Contributor
  include Mongoid::Document
	include Mongoid::Revisions

  field :username

  belongs_to :project

end
