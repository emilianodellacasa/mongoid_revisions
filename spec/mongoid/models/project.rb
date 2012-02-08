class Project
  include Mongoid::Document
  include Mongoid::Revisions

  field :name  

end
