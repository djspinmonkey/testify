module Testify
  module Framework
    def self.all
      Base.subclasses
    end

    ##
    # The class from which all Framework classes must inherit.  Keeps track of
    # all known frameworks and any aliases they're known by.
    #
    class Base
      extend Testify::Aliasable
      extend Testify::SubclassAware

      DEFAULT_STATUSES = [ :passed, :pending, :failed, :error ].collect { |status| Testify::Status::Base.find(status) }

      class << self; alias :old_inherited :inherited end
      def self.inherited(sub)
        old_inherited(sub)
        sub.class_eval { @@statuses = DEFAULT_STATUSES.dup }
      end

      def self.statuses(*stats)
        class_eval do
          if stats.any?
            @@statuses = stats.collect { |stat| @@statuses.push Testify::Status::Base.find(stat) }
          end
          @@statuses || default_statuses
        end
      end
    end
  end
end

