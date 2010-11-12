require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe "Testify::TestResult" do
  it "should be instantializable with a hash of attributes" do
    res = Testify::TestResult.new(:status => :error, :message => "Your test asploded.")
    res.status.should == :error
    res.message.should == "Your test asploded."
  end
end
