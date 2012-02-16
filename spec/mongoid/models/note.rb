class Note
  include Mongoid::Document
	include Mongoid::Revisions

  field :text

	embedded_in :project

end
