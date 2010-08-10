module Testify

  # Runner is a Testify app intended to sit at the top of a Testify stack and
  # provide a simple mechanism for running a set of tests.  If you're writing
  # an autotest-like application, Runner is what you would use.  Runner uses
  # Templatable from the Classy gem, so you can either subclass Runner and use
  # DSL-like class methods to define its behavior, or instantiate it directly
  # and configure the instance.
  #
  # For example,
  #
  #     class SampleRunner < Testify::Runner
  #       framework :rspec
  #       middleware :growl
  #       middleware :red_green
  #     end
  #     @runner = SampleRunner.new
  #
  # would be equivalent to
  #
  #     @runner = Testify::Runner.new
  #     @runner.framework = Testify::Framework::RspecAdaptor
  #     @runner.middleware = [Testify::Middleware::Growl, Testify::Middleware::RedGreen]
  #
  # Which approach is best depends on your needs.
  #
  class Runner
    extend Templatable

    attr_accessor :status, :framework_instance, :test_results
    templatable_attr :framework

    class << self; attr_accessor :framework_class; end

    # Defines and/or returns the framework to use.  This can be any class whose
    # instances are Testify apps, and an instance of this class will be placed
    # at the bottom of the Testify stack used by Runner#run.  Typically, this
    # will probably be a test framework built on Testify or (more likely, at
    # least for now) a Testify adaptor for some existing framework.  If the
    # class descends from Testify::Framework::Base and defines an alias (eg,
    # aka :rspec), you may use that alias instead of passing in the actual
    # class.
    #
    # Example:
    #
    #     class YourRunner < Testify::Runner
    #       framework :rspec
    #     end
    #     @runner = YourRunner.new
    #     @runner.framework         # <= Testify::Framework::RspecAdaptor
    #
    # Note that you can also specify the framework on an instance, using
    # +#framework=+.
    #
    #     @runner = Testify::Runner.new
    #     @runner.framework YourAwesomeTestifyFrameworkClass
    #
    def self.framework (fw = nil)
      self.framework = Testify::Framework::Base.find(fw) if fw
      self.send(:class_variable_get, :@@framework)
    end

    def run ( options = {} )
      @framework_instance ||= framework.new
      env = Testify.env_defaults.merge options
      header, footer, @status, @test_results = @framework_instance.call( env )
    end

  end
end
