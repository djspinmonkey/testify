module Testify
  module Aliasable
    def self.extended (klass) #nodoc;
      klass.class_exec do
        class_variable_set(:@@aliases, {})
      end
    end

    ##
    # When passed a class, just returns it.  When passed a symbol that is an
    # alias for a class, returns that class.
    #
    #   Testify::Framework::Base.find(:rspec)  # => Testify::Framework::RSpec
    #
    def find (klass)
      return klass if klass.kind_of? Class
      class_variable_get(:@@aliases)[klass] or raise ArgumentError, "Could not find alias #{klass}"
    end

    ##
    # Forget all known aliases.
    #
    def forget_aliases
      class_variable_get(:@@aliases).clear
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
      names.each do |name| 
        raise ArgumentError, "Called aka with an alias that is already taken." if class_variable_get(:@@aliases).include? name
        class_variable_get(:@@aliases)[name] = self
      end
    end

    ##
    # Return a hash of known aliases to Class objects
    #
    def aliases
      class_variable_get(:@@aliases).dup
    end

  end
end
