require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mongoid::Revisions do
	before :all do
		Project.delete_all
		@project = Project.create!(:name=>"My first project")
		@project.milestones.create!(:description=>"First Milestone")
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

		it "does not allow modification to its revision" do
			@project.revision=56
			@project.revision.should==0
		end

		it "does not allow modifications to its token" do
			@project.token="ciccio"
			@project.token.should_not=="ciccio"
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
	end

	describe "when I want a new revision" do
		before :all do
			@project.revise
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
			#puts @project.revisions.last.inspect
			@project.revisions.last.milestones.count.should==1
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
end
