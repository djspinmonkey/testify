module Testify
  module Runner

    # Runner is a Testify app intended to sit at the top of a Testify stack and
    # provide a simple mechanism for running a set of tests.  If you're writing
    # an autotest-like application, Runner is what you would use.  Runner uses
    # Templatable from the Classy gem, so you can either subclass Runner and use
    # DSL-like class methods to define its behavior, or instantiate it directly
    # and configure the instance.
    #
    # For example,
    #
    #     class SampleRunner < Testify::Runner::Base
    #       framework :rspec
    #       middleware :growl, :red_green
    #     end
    #
    #     @runner = SampleRunner.new
    #
    # would be equivalent to
    #
    #     @runner = Testify::Runner::Base.new
    #     @runner.framework = Testify::Framework::RspecAdaptor
    #     @runner.middleware = [Testify::Middleware::Growl, Testify::Middleware::RedGreen]
    #
    # Which approach is best depends on your needs, or you can use a mixture of
    # the two.
    #
    class Base
      extend Templatable

      attr_accessor :status, :framework_instance, :test_results
      templatable_attr :framework, :middleware

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
      #     class YourRunner < Testify::Runner::Base
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
      def self.framework( fw = nil )
        self.framework = Testify::Framework::Base.find(fw) if fw
        self.send(:class_variable_get, :@@framework)
      end

      # Allows the framework to be specified on an instance of Runner.  See +.framework+.
      #
      def framework= (fw)
        @framework = Testify::Framework::Base.find(fw)
      end

      # Defines and/or returns the middleware to use, in the same manner as
      # +.framework+.  Note that this completely replaces any previous
      # middleware specified for this class.
      #
      # Example:
      #
      #     class YourRunner < Testify::Runner::Base
      #       middleware :dots, :colorize
      #     end
      #
      def self.middleware( *middlewares )
        self.middleware = middlewares.map { |mw| Testify::Middleware::Base.find(mw) } unless middlewares.empty?
        self.send(:class_variable_get, :@@middleware)
      end

      # Allows the middleware array to be specified for an instance of Runner.  See +.middleware+.
      #
      # Note: The class method accepts a list, but the instance method must be passed an actual array.
      #
      # Example:
      #
      #     runner = YourRunner.new
      #     runner.middleware = [:dots, :colorize]
      #
      def middleware=( middleware )
        @middleware = middleware.map { |mw| Testify::Middleware::Base.find(mw) }
      end

      # Constructs the stack of middleware and framework.  If you are doing
      # something unconventional (eg, creating middleware that requires
      # additional initialization parameters), you may need to override this
      # method.
      #
      def construct_app_stack
        @framework_instance ||= framework.new
        top_app = @framework_instance

        middleware.each do |mw_class|
          top_app = mw_class.new(top_app)
        end

        top_app
      end

      # Run the tests.  Accepts a hash that will be merged in to the default env
      # and passed to the Testify app stack.
      #
      def run( options = {} )
        top_app = construct_app_stack

        env = Testify.env_defaults.merge options
        @test_results = top_app.call(env)

        @status = @test_results.collect(&:status).max  # XXX: Optimize?

        @test_results
      end

    end
  end
end
