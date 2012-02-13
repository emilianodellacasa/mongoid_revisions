class Milestone
  include Mongoid::Document
  include Mongoid::Revisions

  field :description 

  belongs_to :project

end
