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

      @@subclasses = []

      ##
      # Clear all info about known Framework.  Usefull for testing, but it is
      # unlikely you would use it for much else.
      #
      def self.forget_subclasses
        @@subclasses = []
        reset_aliases
      end

      def self.subclasses #nodoc;
        @@subclasses.dup
      end

      def self.inherited(sub) #nodoc;
        @@subclasses.push sub
        sub.statuses :passed, :pending, :failed, :error # default order
      end

      def self.statuses(*stats)
        class_eval do
          if not stats.empty?
            @@statuses = []
            stats.map { |stat| @@statuses.push Testify::Status::Base.find(stat) }
          end
          @@statuses
        end
      end
    end
  end
end

