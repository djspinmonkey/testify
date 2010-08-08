require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe "The Testify module" do

  it "should know its version" do
    # This is a little cheesy, since the same code is used to generate the
    # "correct" version as in the module itself.  But, it's a dead simple
    # method and I'm confident it works, so I'm going to let it slide.
    #
    version = File.read(File.join(File.dirname(__FILE__), '..', 'VERSION')).chomp.split('.').collect { |n| n.to_i }

    Testify.version.should eql version
  end

end
