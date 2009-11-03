module Testify
  module Frameworks

    def self.all
      Base.subclasses
    end

    class Base
      @@subclasses = []

      def self.subclasses
        @@subclasses.dup
      end

      def self.inherited(sub)
        @@subclasses.push sub
      end
    end
  end
end

