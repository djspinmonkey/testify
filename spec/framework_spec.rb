require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Testify::Framework" do
  before :each do
    # Destroy any Framework classes we just created...
    Testify::Framework::Base.subclasses.each do |klass|
      destroy_class klass unless klass.name.include? ':'
    end

    # ...and forget they existed.
    Testify::Framework::Base.forget_subclasses
  end

  it "should keep track of all subclasses (and sub-sub, etc. classes) of ::Base" do
    class SampleFramework1 < Testify::Framework::Base
    end
    class SampleFramework2 < Testify::Framework::Base
    end
    class SampleFramework3 < SampleFramework2
    end

    Testify::Framework::all().should include(SampleFramework1, SampleFramework2, SampleFramework3)
  end

  it "should be able to specify known aliases" do
    class AwesomeTestFramework < Testify::Framework::Base
      aka :awesome
    end

    Testify::Framework::Base.find(:awesome).should equal AwesomeTestFramework
  end

  it "should raise an ArgumentError if a given alias is already taken" do
    class AwesomeTestFramework < Testify::Framework::Base
      aka :awesome
    end

    lambda {
      class AlsoAwesome < Testify::Framework::Base
        aka :awesome
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

