class User
  include Mongoid::Document

  field :username

  has_many :projects

end
