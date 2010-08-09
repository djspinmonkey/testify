require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe "Testify::Runner" do

  before :each do
    Testify::Framework::Base.forget_subclasses
    Testify::Framework::Base.forget_aliases

    destroy_class :SomeTestFramework
    class SomeTestFramework < Testify::Framework::Base
      aka :some_test_framework

      def call (env)
        ['header', 'footer', :passed, []]
      end
    end

    destroy_class :BlankRunner
    class TestRunner < Testify::Runner
    end
    @runner = TestRunner.new
  end

  it "should be able to be subclassed" do
    lambda {
      class AnotherTestRunner < Testify::Runner
      end
    }.should_not raise_error
  end

  it "should be able to specify a test framework by alias" do
    class TestRunner
      framework :some_test_framework
    end

    TestRunner.framework.should eql SomeTestFramework
    @runner.framework.should     eql SomeTestFramework
  end

  it "should be able to specify a test framework by class" do
    class TestRunner
      framework SomeTestFramework
    end

    TestRunner.framework.should eql SomeTestFramework
    @runner.framework.should     eql SomeTestFramework
  end

  context "just created" do
    it "should have a nil status" do
      @runner.status.should be_nil
    end
  end

  context "with a test framework defined" do
    before do
      @runner.framework = SomeTestFramework
    end

    context "after running" do
      before do
        @runner.run
      end

      it "should have the overall status returned by the next app on the stack" do
        @runner.status.should equal :passed
      end
    end
  end
end
