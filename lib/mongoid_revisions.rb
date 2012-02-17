require "mongoid_revisions/version"

module Mongoid
	module Revisions
		extend ActiveSupport::Concern

			included do
				field :revision, :type => Integer, :default => 0
				field :tag, :type => String, :default => "0.0.0"
				field :token, :type => String

				index :token

				set_callback :create, :before, :create_unique_token
			end

			# BLOCK ACCESS TO REVISION ATTRIBUTE
			def revision=(rev)
				# DOES NOTHING
			end

			# BLOCK ACCESS TO TOKEN ATTRIBUTE
			def token=(tok)
				# DOES NOTHING
			end

			# RETURN ALL REVISIONS FOR THIS DOCUMENT
			def revisions
				self.class.where(:token=>self.token).order_by([[:revision,:asc]])
			end 

			# RETURN A SPECIFIC REVISION
			def at_revision(revision)
				self.class.where(:token=>self.token,:revision=>revision.to_i).first
			end

			# RETURN A SPECIFIC REVISION WITH A SPECIFIC TAG
			def tagged(tag)
				self.class.where(:token=>self.token,:tag=>tag).first
			end

			# RETURN NEXT REVISION
			def next
				at_revision(self.revision+1)
			end

			# RETURN PREVIOUS REVISION
			def previous
				at_revision(self.revision-1)
			end

			# ASSIGN A NEW TAG TO THIS REVISION
			def tag_revision(tag)
				self.tag=tag
				self.save
			end

			# CREATE A NEW REVISION FOR THE DOCUMENT
			def revise
				self._revise_or_branch((self.revision || 1) + 1,self.token)
	    end

			# CREATE A NEW BRANCH 
			def branch
				self._revise_or_branch(0)
			end

  	  protected

			def _revise_or_branch(revision,token=nil)
				new = self.class.create self.attributes.except("_id")
        new._token = token
        new._revision = revision
				new.tag = "#{new.revision}.0.0"
        new.save
        self.relations.each do |relation|
					metadata=relation[1]
					if metadata[:relation]==Mongoid::Relations::Embedded::Many or metadata[:relation]==Mongoid::Relations::Embedded::One
						# TODO
					elsif metadata[:relation]!=Mongoid::Relations::Referenced::In
						metadata.class_name.constantize.where(metadata.foreign_key.to_sym=>self.id).each do |child|
  	          new_child = metadata.class_name.constantize.create child.attributes.except("_id")
    	        new_child.revision = child.revision+1
      	      new_child.tag = "#{new_child.revision}.0.0"
        	    new_child[metadata.foreign_key.to_sym]=new.id
	            new_child.save
  	        end
					end
        end
        new
			end

			def _revision=(rev)
				self[:revision]=rev
			end

			def _token=(tok)
				self[:token]=tok
			end

      # CREATE A UNIQUE ID FOR THE DOCUMENT BUT ONLY IF TOKEN IS EMPTY
      def create_unique_token
        self._token=SecureRandom.hex(16) if self.token.nil?
      end
  end
end
