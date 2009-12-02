require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Testify::SubclassAware" do

  before :all do
    # TODO: It would be nicer if this were torn down and re-built between each test.
    
    class ParentA
      extend Testify::SubclassAware

      # This is kind of a pain in the butt, but it's what you need to do if you
      # define your own self.inherited to keep from blowing away the one
      # SubclassAware sets up.  There's a todo in subclass_aware.rb about this.
      class << self; alias :old_inherited :inherited end
      def self.inherited(sub)
        old_inherited(sub)
        # do your stuff here
      end
    end

    class ParentB
      extend Testify::SubclassAware
    end

    class SubclassA1 < ParentA; end
    class SubclassA2 < ParentA; end
    class SubclassA3 < ParentA; end

    class SubclassB1 < ParentB; end
    class SubclassB2 < ParentB; end
    class SubclassB3 < ParentB; end
  end

  it "should keep track of all subclasses (and sub-sub, etc. classes) of a module which extends it" do
    ParentA::subclasses.should include(SubclassA1, SubclassA2, SubclassA3)
    ParentB::subclasses.should include(SubclassB1, SubclassB2, SubclassB3)
    ParentA::subclasses.should have(3).subclasses
    ParentB::subclasses.should have(3).subclasses
  end

  it "should not confuse the subclasses of two different extending classes" do
    ParentA.subclasses.should_not include(SubclassB1, SubclassB2, SubclassB3)
    ParentB.subclasses.should_not include(SubclassA1, SubclassA2, SubclassA3)
  end

  it "should forget all subclasses when forget_subclasses() is called" do
    ParentA.forget_subclasses
    ParentA.subclasses.should be_empty
    ParentB.subclasses.should have(3).subclasses
  end

end

