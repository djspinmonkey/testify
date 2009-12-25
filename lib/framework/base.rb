module Testify
  module Framework
    def self.all
      Base.subclasses
    end

    DEFAULT_STATUSES = [ :passed, :pending, :failed, :error ].collect { |status| Testify::Status::Base.find(status) }

    ##
    # The class from which all Framework classes must inherit.  Keeps track of
    # all known frameworks and any aliases they're known by.
    #
    class Base
      extend Aliasable
      extend SubclassAware

      # Annoying alias chain required to preserve inerited() methods from modules
      class << self; alias :old_inherited :inherited end
      def self.inherited(sub)
        old_inherited(sub)
        sub.class_eval { @statuses = Testify::Framework::DEFAULT_STATUSES.dup }
      end

      def self.statuses(*statuses)
        if statuses.any?
          @statuses = statuses.collect { |status| Testify::Status::Base.find(status) }
        end
        @statuses
      end
    end
  end
end

