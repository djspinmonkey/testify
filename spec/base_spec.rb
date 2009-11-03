require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Testify::Base" do

  before do
    class TesterApp < Testify::Base
    end

    @tester = TesterApp.new
  end

  it "should be able to be subclassed" do
    lambda {
      class AnotherTesterApp < Testify::Base
      end
    }.should_not raise_error
  end

  it "should be able to specify a framework by alias" do
    class TesterApp
      framework :rspec
    end
    @tester.framework.should eql Testify::Frameworks::RSpec
  end

  describe '#run' do
    it "should return a ResultSet" do
      @tester.run.should be_a(Testify::ResultSet)
    end
  end

end
