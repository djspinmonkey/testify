module Testify
  # The module which all Framework classes are recommended to inherit.
  # Framework provides a few utility methods and a means to keep track of all
  # Framework classes (via Aliasable).  Framework objects are Testify apps, so
  # subclasses must implement a +call+ method as described in the README.rdoc
  # file.  It is also good practice to declare at least one alias (see the
  # Aliasable module in the Classy gem for more details).
  #
  module Framework
    include Aliasable

    # The default set of statuses
    #
    DEFAULT_STATUSES = [ :passed, :pending, :failed, :error ]

    # Extend the ClassMethods module and set the default statuses.
    #
    # :nodoc:
    #
    def self.included( klass )
      klass.extend Testify::Framework::ClassMethods
      klass.statuses *Testify::Framework::DEFAULT_STATUSES.dup
      super
    end

    # Returns an array of absolute paths to each file defined by an +env+
    # hash.  The default implementation either returns the array of files, if
    # :files is defined in the hash, or returns every file found in a
    # traversal of the path in the :path key.  Raises an exception if neither
    # is defined, since that is not a valid +env+ hash.
    #
    # If a particular framework should only process files with names matching
    # a particular glob pattern (eg, RSpec only wants files that match
    # `*_spec.rb`), it can specify this with +file_pattern+.
    #
    def files( env )
      return env[:files] if env.include? :files
      raise(ArgumentError, "env hash must include either :files or :path") unless env.include? :path

      file_glob = self.class.class_eval { @file_pattern } || '*'
      Dir.glob(File.join(env[:path], '**', file_glob))
    end

    # Run all the appropriate hooks before running any tests at all.
    #
    def run_before_all_hooks( env )
      env[:hooks][:before_all].each { |hook| hook.call }
    end

    # Run all the appropriate hooks before running each test.
    #
    def run_before_each_hooks( env )
      env[:hooks][:before_each].each { |hook| hook.call }
    end

    # Run all the appropriate hooks after running all the tests
    #
    def run_after_all_hooks( env, results )
      env[:hooks][:after_all].each { |hook| hook.call(results) }
    end

    # Run all the appropriate hooks after running each test individually
    # (including the hooks for a particular status).
    #
    def run_after_each_hooks( env, result )
      hooks = env[:hooks][:after_each]
      hooks += env[:hooks][:after_status][result.status].to_a  # .to_a in case it's nil
      hooks.each { |hook| hook.call(result) }
    end

    module ClassMethods
      # Gets and sets an array of symbols corresponding to the possible
      # TestResult statuses that might be set by this Framework.
      #
      # For example, a framework with tests that can only pass or fail might
      # like like this:
      #
      #   class SomeFramework 
      #     include Testify::Framework
      #
      #     statuses :passed, :failed
      #
      #     ...
      #   end
      #
      #   SomeFramework.statuses  # => [ :passed, :failed ]
      #
      def statuses( *new_statuses )
        if new_statuses.any?
          @statuses = new_statuses
        end
        @statuses
      end

      # Accepts a glob pattern that limits the paths returned by `#files`.
      # Only paths with filenames that match this pattern will be returned by
      # +.files+.
      #
      # For example, if all your framework's test files should end in
      # _mytests.rb, you might do this:
      #
      #   class MyTestFramework
      #     include Testify::Framework
      #
      #     file_pattern '*_mytests.rb'
      #
      #     ...
      #   end
      #
      def file_pattern( pattern )
        self.class_eval { @file_pattern = pattern }
      end
    end
  end
end
