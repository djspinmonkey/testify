module Testify
  module Framework

    def self.all
      Base.subclasses
    end

    ##
    # When passed a class, just returns it.  When passed a symbol that is an
    # alias for a Testify::Framework class, returns that class.
    #
    #   Testify::Framework::find(:rspec)  # => Testify::Framework::RSpec
    #
    def self.find (fw)
      return fw if fw.kind_of? Class
      Testify::Framework::Base.aliases[fw]
    end

    ##
    # The class from which all Framework classes must inherit.  Keeps track of
    # all known frameworks and any aliases they're known by.
    #
    class Base
      @@subclasses = []
      @@aliases = {}

      ##
      # Clear all info about known Framework.  Usefull for testing, but it is
      # unlikely you would use it for much else.
      #
      def self.forget_subclasses
        @@subclasses = []
        @@aliases = {}
      end

      ##
      # Specifies a symbol (or several) that a given framework might be known
      # by.  For example, if you wanted to refer to RSpec by :rspec or :spec,
      # you might do this:
      #
      #   class RSpec
      #     aka :rspec, spec
      #     ...
      #   end
      #
      def self.aka (*names)
        class_eval do
          names.each do |name| 
            raise ArgumentError, "Called aka with an alias that is already taken." if @@aliases.include? name
            @@aliases[name] = self
          end
        end
      end

      def self.aliases #nodoc;
        @@aliases.dup
      end

      def self.subclasses #nodoc;
        @@subclasses.dup
      end

      def self.inherited(sub) #nodoc;
        @@subclasses.push sub
      end
    end
  end
end

