require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Testify::SubclassAware" do

  it "should keep track of all subclasses (and sub-sub, etc. classes) of a module which extends it" do
    class Parent
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
    class SubclassA < Parent
    end
    class SubclassB < Parent
    end
    class SubclassC < Parent
    end

    Parent::subclasses().should include(SubclassA, SubclassB, SubclassC)
  end

end

