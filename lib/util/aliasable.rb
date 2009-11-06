module Testify
  module Aliasable
    def self.extended (klass) #nodoc;
      klass.class_eval do
        @@aliases = {}
      end
    end

    ##
    # When passed a class, just returns it.  When passed a symbol that is an
    # alias for a class, returns that class.
    #
    #   Testify::Framework::find(:rspec)  # => Testify::Framework::RSpec
    #
    def find (klass)
      return klass if klass.kind_of? Class
      @@aliases[klass]
    end

    ##
    # Forget all known aliases.
    #
    def reset_aliases
      @@aliases.clear
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
    def aka (*names)
      class_eval do
        names.each do |name| 
          raise ArgumentError, "Called aka with an alias that is already taken." if @@aliases.include? name
          @@aliases[name] = self
        end
      end
    end

    ##
    # Return a hash of known aliases to Class objects
    #
    def aliases
      @@aliases.dup
    end

  end
end
