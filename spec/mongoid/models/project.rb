class Project
  include Mongoid::Document
  include Mongoid::Revisions

  field :name  

  has_many :milestones

end
