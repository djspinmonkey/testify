require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Testify::Frameworks" do

  it "should keep track of all subclasses of ::Base" do
    class SampleFramework1 < Testify::Frameworks::Base
    end
    class SampleFramework2 < Testify::Frameworks::Base
    end

    Testify::Frameworks::all().should include(SampleFramework1, SampleFramework2)
  end

end

