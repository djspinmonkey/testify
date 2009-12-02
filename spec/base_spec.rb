require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Testify::Base" do

  before :each do
    Testify::Framework::Base.forget_subclasses
    Testify::Framework::Base.forget_aliases

    destroy_class :SomeTestFramework
    class SomeTestFramework < Testify::Framework::Base
      aka :some_test_framework
    end

    destroy_class :TesterApp
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

  it "should be able to specify a test framework by alias" do
    class TesterApp
      framework :some_test_framework
    end

    TesterApp.framework.should eql SomeTestFramework
    @tester.framework.should   eql SomeTestFramework
  end

  it "should be able to specify a test framework by class" do

    class TesterApp
      framework SomeTestFramework
    end

    TesterApp.framework.should eql SomeTestFramework
    @tester.framework.should   eql SomeTestFramework
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

    it "should have a status" do
      @tester.status.should be_a_kind_of Testify::Status::Base
    end
  end

end
