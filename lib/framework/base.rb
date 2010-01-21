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
    end
  end
end

