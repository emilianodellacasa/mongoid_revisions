class Version
  include Mongoid::Document
	include Mongoid::Revisions

  field :description

	embedded_in :project

end
