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

      def self.statuses(*stats)
        class_eval do
          if stats.any?
            @@statuses = stats.collect { |stat| @@statuses.push Testify::Status::Base.find(stat) }
          end
          @@statuses || DEFAULT_STATUSES
        end
      end
    end
  end
end

