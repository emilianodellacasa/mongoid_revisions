require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mongoid::Revisions do
	before :all do
		Project.delete_all
		@user = User.create!(:username=>"teddy")
		@project = Project.create!(:name=>"My first project",:user_id=>@user.id)
		@project.milestones.create!(:description=>"First Milestone")
		@project.create_configuration(:directory_name=>"/opt/project")
		@project.notes.create!(:text=>"This is a note")
		@project.create_version(:description=>"1.0.0")
		@project.teams.create(:name=>"Team A")
	end

	context "just created" do
		it "is at revision 0" do
			@project.revision.should==0
		end

		it "has a default tag" do
			@project.tag.should=="0.0.0"
		end 

		it "has a unique token" do
			@project.token.should_not be_nil
		end

		it "has just 1 revision" do
			@project.revisions.count.should==1
		end

		it "can have a different tag" do
			@project.tag_revision("Alpha Stage")
			@project.tag.should=="Alpha Stage"
		end

		it "has a single milestone" do
			@project.milestones.count==1
		end

		it "has a single note" do
      @project.notes.count==1
    end

		it "has a single team" do
			@project.teams.count==1
		end

		it "has a single configuration" do
      @project.configuration.should_not be_nil
    end

		it "does not allow modification to its revision" do
			@project.revision=56
			@project.revision.should==0
		end

		it "does not allow modifications to its token" do
			@project.token="ciccio"
			@project.token.should_not=="ciccio"
		end

		it "should have a index on token" do
			Project.index_options.count.should==1
		end
	end 

  
	describe "when I do not want a new revision" do
	  before :all do
			@project.save
		end

		it "has 1 revisions" do
			@project.revisions.count.should==1
		end

		it "it is at revision 0" do
			@project.revision.should==0
		end

		it "has a single milestone" do
			@project.milestones.count==1
		end

		it "has a single note" do
      @project.notes.count==1
    end

		it "has a single version" do
      @project.version.should_not be_nil
    end
	end

	describe "when I want a new revision" do
		before :all do
			@new_revised_project = @project.revise
		end

		it "has 2 revisions" do
			@project.revisions.count.should==2
		end

		it "it is at revision 0" do
			@project.revision.should==0
		end

		it "last revision is at revision 1" do
			@project.revisions.last.revision.should==1
		end

		it "returned object should be last revision" do
			@project.revisions.last.should==@new_revised_project
		end

		it "last revision has the default tag" do
			@project.revisions.last.tag.should=="1.0.0"
		end

		it "has 2 revisions" do
			@project.revisions.count.should==2
		end

		it "creates a new milestone" do
			Milestone.count.should==2
		end

    it "last revision has a single milestone" do
			@project.revisions.last.milestones.count.should==1
    end

    it "last revision has a single team" do
      @project.revisions.last.teams.count.should==1
    end

		it "original revision has a single team" do
      @project.teams.count.should==1
    end

		it "original project has a single note" do
      @project.notes.count.should==1
    end

		it "last revision has a single note" do
			pending # EMBEDDED RELATIONS NOT SUPPORTED (YET)
      @project.revisions.last.notes.count.should==1
    end

  	it "last revision has a single version" do
      pending # EMBEDDED RELATIONS NOT SUPPORTED (YET)
      @project.revisions.last.version.should_not be_nil
    end

		it "does not create a new User" do
			User.count.should==1
		end

		it "should create a new configuration" do
			Configuration.count.should==2
		end

		it "last revision has a single configuration" do
      @project.revisions.last.configuration.should_not be_nil
    end

		it "should allow me to access a particular revision" do
			@project.at_revision(1).revision.should==1
		end

		it "should allow me to access a particular revision using its tag" do
			@project.tagged("1.0.0").tag.should=="1.0.0"
		end

		it "should allow me to navigate to the next revision" do
			@project.next.revision.should==@project.revision+1
		end

		it "should allow me to navigate to the previous revision" do
      @new_revised_project.previous.revision.should==@project.revision
    end

		it "should me give me nil if there is no next revision" do
			@new_revised_project.next.should==nil
		end

		it "should me give me nil if there is no previous revision" do
			@project.previous.should==nil
    end
  end

	describe "adding a random number of revisions" do
		it "should give me the right number of revisions" do
			count = rand(10)
			count.times do 
				@project.revise
			end
			@project.revisions.count.should==(count+2)
		end
	end

	describe "when I want a new branch" do
    before :all do
      @new_project = @project.branch
    end

		it "should be at revision 0" do
			@new_project.revision.should==0
		end

		it "should change token" do
			@new_project.token.should_not==@project.token
		end
	
		it "should have 1 milestone" do
			@new_project.milestones.count.should==1
		end

		it "should have 1 revision" do
			@new_project.revisions.count.should==1
		end
	end
end
