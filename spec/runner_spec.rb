require_relative 'spec_helper'

describe "Testify::Runner::Base" do

  before :each do
    Testify::Middleware::Base.forget_aliases
    Testify::Framework::Base.forget_subclasses
    Testify::Framework::Base.forget_aliases

    destroy_class :SomeMiddleware
    class SomeMiddleware < Testify::Middleware::Base
      aka :some_middleware
    end

    destroy_class :SomeMoreMiddleware
    class SomeMoreMiddleware < Testify::Middleware::Base
      aka :more_middleware
    end

    destroy_class :SomeTestFramework
    class SomeTestFramework < Testify::Framework::Base
      aka :some_test_framework
      attr_accessor :env

      def call (env)
        @env = env
        ['header', 'footer', :passed, []]
      end
    end

    destroy_class :BlankRunner
    class TestRunner < Testify::Runner::Base
    end
    @runner = TestRunner.new

    @test_path = File.expand_path(File.join(File.dirname(__FILE__), 'sample_tests'))
  end

  it "should be able to specify a test framework by alias" do
    class TestRunner
      framework :some_test_framework
    end

    TestRunner.framework.should eql SomeTestFramework
    @runner.framework.should eql SomeTestFramework
  end

  it "should be able to specify a test framework by class" do
    class TestRunner
      framework SomeTestFramework
    end

    TestRunner.framework.should eql SomeTestFramework
    @runner.framework.should eql SomeTestFramework
  end

  it "should be able to specify middleware by alias" do
    class TestRunner
      middleware :some_middleware, :more_middleware
    end

    TestRunner.middleware.should eql [SomeMiddleware, SomeMoreMiddleware]
    @runner.middleware.should eql [SomeMiddleware, SomeMoreMiddleware]
  end

  context "#run" do
    it "should accept options and put them in the env hash" do
      framework = SomeTestFramework.new
      @runner.framework_instance = framework
      @runner.run :foo => 'bar'
      framework.env[:foo].should == 'bar'
    end
  end

  context "just created" do
    it "should have a nil status" do
      @runner.status.should be_nil
    end
  end

  context "with a test framework defined" do
    before do
      @runner.framework = SampleFramework
    end

    context "after running" do
      before do
        test_path = File.join(File.dirname(__FILE__), "sample_tests")
        @runner.run :path => test_path
      end

      it "should have a status" do
        @runner.status.should_not be_nil
      end
    end
  end
end
