require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe "Testify" do

  context '.env_defaults' do
    it "should provide an env hash with some default values" do
      defaults = Testify.env_defaults

      # Just check that these keys were defined
      defaults.keys.should include( :testify_errors, :testify_output )

      # Verify the values on these ones
      defaults[:testify_version].should == Testify.version
      defaults[:testify_hooks].should == { :before_all => [], :after_all => [], :before_each => [], :after_each => [], :after_status => {} }
    end
  end

  context '.version' do
    it "should return an array of three integers" do
      version = Testify.version
      version.should have(3).parts
      version.each { |n| n.should be_an Integer }
    end
  end

end
