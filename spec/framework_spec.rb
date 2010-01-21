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

  it "should be able to specify a status ranking without affecting other Frameworks" do
    class VanillaTestFramework < Testify::Framework::Base
    end

    class ChangedTestFramework < Testify::Framework::Base
      statuses :passed, :failed, :exploded
    end

    VanillaTestFramework.statuses.should eql Testify::Framework::DEFAULT_STATUSES
    ChangedTestFramework.statuses.should eql [ :passed, :failed, :exploded ]
  end

end

