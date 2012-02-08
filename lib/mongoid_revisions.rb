require "mongoid_revisions/version"

module Mongoid
  module Revisions
    extend ActiveSupport::Concern

    included do
      field :revision, :type => Integer, :default => 1
      field :tag, :type => String, :default => "1.0.0"
      field :token, :type => String


      set_callback :create, :before, :create_unique_token
    end

    # CREATE A UNIQUE ID FOR THE DOCUMENT BUT ONLY IF TOKEN IS EMPTY
    def create_unique_token
	self.token=SecureRandom.hex(16) if self.token.nil?
    end

    # RETURN ALL REVISIONS FOR THIS DOCUMENT
    def revisions
	self.class.where(:token=>self.token) #.order_by([[:revision,:asc]])
    end 

    # ASSIGN A NEW TAG TO THIS REVISION
    def tag_revision(tag)
	self.tag=tag
	self.save
    end

    # CREATE A NEW REVISION FOR THE DOCUMENT
    def revise
	new_revision = self.class.create self.attributes.except("_id")
	new_revision.revision = (self.revision || 1) + 1
	new_revision.tag = "#{new_revision.revision}.0.0"
	new_revision.save
    end
  end
end
