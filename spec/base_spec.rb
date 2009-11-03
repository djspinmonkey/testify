require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Testify::Base" do
  it "should be able to be subclassed" do
    lambda {
      class MyTestament < Testify::Base
      end
    }.should_not raise_error
  end
end
