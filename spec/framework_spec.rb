require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Testify::Frameworks" do

  it "should keep track of all subclasses of ::Base" do
    class SampleFramework1 < Testify::Frameworks::Base
    end
    class SampleFramework2 < Testify::Frameworks::Base
    end

    Testify::Frameworks::all().should include(SampleFramework1, SampleFramework2)
  end

  it "should be able to specify known aliases" do
    class SneakyMcGee < Testify::Frameworks::Base
      aka :mr_sneaks
    end

    Testify::Frameworks::find(:mr_sneaks).should equal SneakyMcGee
  end

  it "should raise an ArgumentError if a given alias is already taken" do
    class AwesomeTestFramework < Testify::Frameworks::Base
      aka :awesome
    end

    lambda {
      class AlsoAwesome < Testify::Frameworks::Base
        aka :awesome
      end
    }.should raise_error(ArgumentError)

  end

end

