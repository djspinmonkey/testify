require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Testify::Framework" do

  it "should know about all Framework classes" do
    class SampleFramework < Testify::Framework::Base
    end

    Testify::Framework::all().should include(SampleFramework)
  end

  it "should be able to specify known aliases" do
    class AwesomeTestFramework < Testify::Framework::Base
      aka :awesome
    end

    Testify::Framework::Base.find(:awesome).should equal AwesomeTestFramework
  end

  it "should raise an ArgumentError if a given alias is already taken" do
    class RepeatedAliasTestFramework < Testify::Framework::Base
      aka :repeat
    end

    lambda {
      class ThisIsTheRepeat < Testify::Framework::Base
        aka :repeat
      end
    }.should raise_error(ArgumentError)

  end

  it "should be able to specify a status ranking" do
    class Exploded < Testify::Status::Base
      aka :exploded
    end

    class SampleTestFramework < Testify::Framework::Base
      statuses :passed, :failed, :exploded
    end

    SampleTestFramework.statuses.should eql [ Testify::Status::Passed, Testify::Status::Failed, Exploded ]
  end

end

