require_relative 'spec_helper'

describe "Testify::Framework" do

  before :all  do
    Testify::Framework.forget_aliases

    destroy_class :VanillaFramework
    class VanillaFramework 
      include Testify::Framework
      aka :vanilla
    end
    @framework = VanillaFramework.new
  end

  it "should be able to specify known aliases" do
    Testify::Framework.find(:vanilla).should equal VanillaFramework
  end

  it "should raise an ArgumentError if a given alias is already taken" do
    lambda {
      class ThisIsTheRepeat 
        include Testify::Framework
        aka :vanilla
      end
    }.should raise_error(ArgumentError)

  end

  it "should be able to specify a status ranking without affecting other Frameworks" do
    class ChangedFramework 
      include Testify::Framework
      statuses :passed, :failed, :exploded
    end

    VanillaFramework.statuses.should eql Testify::Framework::DEFAULT_STATUSES
    ChangedFramework.statuses.should eql [ :passed, :failed, :exploded ]
  end

  context '#files' do
    before do 
      @test_path = File.join(File.dirname(__FILE__), "sample_tests")
      all_files = ['failing_tests', 'mixed_tests', 'passing_tests', 'test_helper']
      test_files = all_files - ['test_helper']
      @all_paths  = all_files.collect  { |f| File.join(File.dirname(__FILE__), 'sample_tests', f) }
      @test_paths = test_files.collect { |f| File.join(File.dirname(__FILE__), 'sample_tests', f) }
    end

    after do
      VanillaFramework.file_pattern nil
    end

    it "should find files specified by :path" do
      env = { :path => @test_path }
      @framework.files(env).sort.should eql @all_paths
    end

    it "should find files specified by :files" do
      env = { :files => @all_paths }
      @framework.files(env).sort.should eql @all_paths
    end

    it "should raise an ArgumentError if neither :files nor :path is defined" do
      env = {}
      lambda { 
        @framework.files(env) 
      }.should raise_exception ArgumentError
    end

    it "should respect the .file_pattern setting" do
      class VanillaFramework
        file_pattern '*_tests'
      end

      env = { :path => @test_path }
      @framework.files(env).sort.should eql @test_paths
    end
  end

end

