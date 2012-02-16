class Configuration
  include Mongoid::Document
	include Mongoid::Revisions

  field :directory_name

	belongs_to :project

end
