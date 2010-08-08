require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe "Testify::Runner" do

  before :each do
    Testify::Framework::Base.forget_subclasses
    Testify::Framework::Base.forget_aliases

    destroy_class :SomeTestFramework
    class SomeTestFramework < Testify::Framework::Base
      aka :some_test_framework

      def call ()
        ['header', 'footer', :passed, []]
      end
    end

    destroy_class :SomeTestRunner
    class SomeTestRunner < Testify::Runner
    end

    @tester = SomeTestRunner.new
  end

  it "should be able to be subclassed" do
    lambda {
      class AnotherTestRunner < Testify::Runner
      end
    }.should_not raise_error
  end

  it "should be able to specify a test framework by alias" do
    class SomeTestRunner
      framework :some_test_framework
    end

    SomeTestRunner.framework.should eql SomeTestFramework
    @tester.framework.should        eql SomeTestFramework
  end

  it "should be able to specify a test framework by class" do

    class SomeTestRunner
      framework SomeTestFramework
    end

    SomeTestRunner.framework.should eql SomeTestFramework
    @tester.framework.should        eql SomeTestFramework
  end

  context "just created" do
    it "should have a nil status" do
      @tester.status.should be_nil
    end
  end

  context "after running" do
    before do
      @tester.run
    end

    it "should have a non-nil status" do
      @tester.status.should_not be_nil
    end
  end

end
