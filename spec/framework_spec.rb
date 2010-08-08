require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe "Testify::Framework" do

  before :all  do
    destroy_class :VanillaFramework
    Testify::Framework::Base.forget_aliases
    Testify::Framework::Base.forget_subclasses
    class VanillaFramework < Testify::Framework::Base
      aka :vanilla
    end
    @framework = VanillaFramework.new
  end

  it "should know about all Framework classes" do
    Testify::Framework::all().should include(VanillaFramework)
  end

  it "should be able to specify known aliases" do
    Testify::Framework::Base.find(:vanilla).should equal VanillaFramework
  end

  it "should raise an ArgumentError if a given alias is already taken" do
    lambda {
      class ThisIsTheRepeat < Testify::Framework::Base
        aka :vanilla
      end
    }.should raise_error(ArgumentError)

  end

  it "should be able to specify a status ranking without affecting other Frameworks" do
    class ChangedFramework < Testify::Framework::Base
      statuses :passed, :failed, :exploded
    end

    VanillaFramework.statuses.should eql Testify::Framework::DEFAULT_STATUSES
    ChangedFramework.statuses.should eql [ :passed, :failed, :exploded ]
  end

  context '#files' do
    before do 
      @test_path = File.join(File.dirname(__FILE__), "sample_tests")
      @all_files = [ File.join(@test_path, "fail.spec"), File.join(@test_path, "pass.spec") ]
    end

    it "should find files specified by :path" do
      env = { :path => @test_path }
      @framework.files(env).sort.should eql @all_files
    end

    it "should find files specified by :files" do
      env = { :files => @all_files }
      @framework.files(env).sort.should eql @all_files
    end

    it "should raise an ArgumentError if neither :files nor :path is defined" do
      env = {}
      lambda { 
        @framework.files(env) 
      }.should raise_exception ArgumentError
    end
  end

end

