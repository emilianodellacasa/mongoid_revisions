class Deadline
  include Mongoid::Document
  include Mongoid::Revisions

  field :description 

  belongs_to :milestone

end
