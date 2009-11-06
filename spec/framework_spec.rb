require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Testify::Frameworks" do
  before :each do
    # Destroy any Framework classes we just created...
    Testify::Frameworks::Base.subclasses.each do |klass|
      destroy_class klass unless klass.name.include? ':'
    end

    # ...and forget they existed.
    Testify::Frameworks::Base.forget_subclasses
  end

  it "should keep track of all subclasses (and sub-sub, etc. classes) of ::Base" do
    class SampleFramework1 < Testify::Frameworks::Base
    end
    class SampleFramework2 < Testify::Frameworks::Base
    end
    class SampleFramework3 < SampleFramework2
    end

    Testify::Frameworks::all().should include(SampleFramework1, SampleFramework2, SampleFramework3)
  end

  it "should be able to specify known aliases" do
    class AwesomeTestFramework < Testify::Frameworks::Base
      aka :awesome
    end

    Testify::Frameworks::find(:awesome).should equal AwesomeTestFramework
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

