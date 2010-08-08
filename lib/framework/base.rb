module Testify
  module Framework
    def self.all
      Base.subclasses
    end

    # The default set of statuses
    #
    DEFAULT_STATUSES = [ :passed, :pending, :failed, :error ]

    # The class from which all Framework classes should inherit.  Keeps track
    # of all known frameworks and any aliases they're known by.  Framework
    # objects are Testify apps, so subclasses must implement a +call+ method as
    # described in the README.rdoc file.  It is also good practice to declare
    # at least one alias (see the Aliasable module in the Classy gem for more
    # details).
    #
    class Base
      extend Aliasable
      extend SubclassAware

      # Annoying alias chain required to preserve inerited() methods from modules
      class << self; alias :old_inherited :inherited end
      def self.inherited(sub) #:nodoc:
        old_inherited(sub)
        sub.class_eval { @statuses = Testify::Framework::DEFAULT_STATUSES.dup }
      end

      # Gets and sets an array of symbols corresponding to the possible
      # TestResult statuses that might be set by this Framework.
      #
      # For example, a framework with tests that can only pass or fail might
      # like like this:
      #
      #   class SomeFramework < Testify::Framework::Base
      #     statuses :passed, :failed
      #     ...
      #   end
      #
      #   SomeFramework.statuses  # => [ :passed, :failed ]
      #
      def self.statuses(*new_statuses)
        if new_statuses.any?
          @statuses = new_statuses
        end
        @statuses
      end

      # Returns an array of absolute paths to each file defined by an +env+
      # hash.  The default implementation either returns the array of files, if
      # :files is defined in the hash, or returns every file found in a
      # traversal of the path in the :path key.  Raises an exception if neither
      # is defined, since that is not a valid +env+ hash.
      #
      # If a particular framework should only process particular files (eg,
      # RSpec only wants .spec files), it should override this method
      # appropriately.
      #
      def files (env) 
        return env[:files] if env.include? :files
        raise(ArgumentError, "env hash must include either :files or :path") unless env.include? :path
        Dir.glob(File.join(env[:path], '**', '*'))
      end
    end
  end
end

